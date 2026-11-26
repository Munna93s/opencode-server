#!/usr/bin/env bash
set -euo pipefail

# Start opencode serve + cloudflared quick tunnel with watchdog auto-recovery.
# Prints tunnel URL when available. Designed for CI/server bootstrap.

PORT="${OPENCODE_PORT:-4096}"
HOST="${OPENCODE_HOST:-0.0.0.0}"
LOG_DIR="/tmp/opencode"
CF_LOG="/tmp/cf.log"
URL_FILE="$LOG_DIR/tunnel_url.txt"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Fallback API keys (GEMINI_API_KEY / GROQ_API_KEY) live outside the repo.
ENV_FILE="$HOME/.config/opencode/.env.local"
if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$ENV_FILE"
  set +a
fi

mkdir -p "$LOG_DIR"
: > "$CF_LOG" 2>/dev/null || true

if ! curl -fsS --max-time 3 "http://127.0.0.1:${PORT}/" >/dev/null 2>&1; then
  nohup opencode serve --port "$PORT" --hostname "$HOST" > /tmp/opencode.log 2>&1 &
  sleep 5
fi

if ! pgrep -f "cloudflared tunnel --url http://localhost:${PORT}" >/dev/null 2>&1; then
  nohup cloudflared tunnel --url "http://localhost:${PORT}" --protocol http2 --retries 10 > "$CF_LOG" 2>&1 &
fi

# Start watchdog for auto-recovery (idempotent)
chmod +x "$SCRIPT_DIR/opencode-watchdog.sh" 2>/dev/null || true
nohup "$SCRIPT_DIR/opencode-watchdog.sh" >> "$LOG_DIR/watchdog.log" 2>&1 &

for i in $(seq 1 45); do
  TUNNEL_URL="$(grep -o 'https://[a-zA-Z0-9-]*\.trycloudflare\.com' "$CF_LOG" | head -n 1 || true)"
  if [ -n "$TUNNEL_URL" ]; then
    printf '%s\n' "$TUNNEL_URL" > "$URL_FILE"
    echo "$TUNNEL_URL"
    exit 0
  fi
  sleep 2
done

echo "ERROR: tunnel URL not found" >&2
tail -n 80 "$CF_LOG" >&2 || true
exit 1
