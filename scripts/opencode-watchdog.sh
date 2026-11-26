#!/usr/bin/env bash
set -euo pipefail

# Watches OpenCode server + Cloudflare quick tunnel and restarts them if unhealthy/down.
# - Keeps local server on http://127.0.0.1:4096
# - Restarts cloudflared quick tunnel on failure (URL may change on restart)
# - Writes latest tunnel URL to /tmp/opencode/tunnel_url.txt
# Logs: /tmp/opencode/watchdog.log, /tmp/opencode.log, /tmp/cf.log

PORT="${OPENCODE_PORT:-4096}"
HOST="${OPENCODE_HOST:-0.0.0.0}"
CHECK_INTERVAL="${WATCHDOG_INTERVAL:-15}"
LOG_DIR="/tmp/opencode"
WATCHDOG_LOG="$LOG_DIR/watchdog.log"
OPENCODE_LOG="/tmp/opencode.log"
CF_LOG="/tmp/cf.log"
URL_FILE="$LOG_DIR/tunnel_url.txt"
LOCK_DIR="$LOG_DIR/opencode-watchdog.lock"

# Preserve fallback API keys when the watchdog restarts `opencode serve`.
ENV_FILE="$HOME/.config/opencode/.env.local"
if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$ENV_FILE"
  set +a
fi

mkdir -p "$LOG_DIR"

log() {
  printf '[%s] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*" >> "$WATCHDOG_LOG"
}

# Prevent duplicate watchdogs
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  if [ -f "$LOCK_DIR/pid" ] && kill -0 "$(cat "$LOCK_DIR/pid" 2>/dev/null)" 2>/dev/null; then
    echo "watchdog already running (pid $(cat "$LOCK_DIR/pid"))"
    exit 0
  fi
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
echo $$ > "$LOCK_DIR/pid"
cleanup() { rm -rf "$LOCK_DIR"; }
trap cleanup EXIT INT TERM

server_healthy() {
  curl -fsS --max-time 5 "http://127.0.0.1:${PORT}/" >/dev/null 2>&1
}

cloudflared_running() {
  pgrep -f "cloudflared tunnel --url http://localhost:${PORT}" >/dev/null 2>&1 \
    || pgrep -f "cloudflared tunnel --url http://127.0.0.1:${PORT}" >/dev/null 2>&1
}

start_server() {
  log "starting opencode serve on ${HOST}:${PORT}"
  nohup opencode serve --port "$PORT" --hostname "$HOST" >> "$OPENCODE_LOG" 2>&1 &
  sleep 3
}

capture_tunnel_url() {
  local i url=""
  for i in $(seq 1 45); do
    url="$(grep -o 'https://[a-zA-Z0-9-]*\.trycloudflare\.com' "$CF_LOG" 2>/dev/null | tail -n 1 || true)"
    if [ -n "$url" ]; then
      printf '%s\n' "$url" > "$URL_FILE"
      log "tunnel url: $url"
      echo "TUNNEL_URL=$url"
      return 0
    fi
    sleep 2
  done
  log "warning: tunnel URL not detected yet after restart"
  return 1
}

start_tunnel() {
  log "starting cloudflared quick tunnel -> http://localhost:${PORT}"
  printf '\n[%s] --- restarting cloudflared tunnel ---\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" >> "$CF_LOG"
  nohup cloudflared tunnel --url "http://localhost:${PORT}" --protocol http2 --retries 10 >> "$CF_LOG" 2>&1 &
  capture_tunnel_url || true
}

log "watchdog started (pid $$, interval ${CHECK_INTERVAL}s)"

while true; do
  if ! server_healthy; then
    log "opencode health check failed; restarting server"
    pkill -f "opencode serve --port ${PORT}" >/dev/null 2>&1 || true
    sleep 1
    start_server
  fi

  if ! cloudflared_running; then
    log "cloudflared tunnel not running; restarting tunnel"
    start_tunnel
  fi

  sleep "$CHECK_INTERVAL"
done
