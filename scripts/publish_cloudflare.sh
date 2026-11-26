#!/bin/bash
# Publish any file via cloudflared tunnel and print the public download URL.
# Usage: ./scripts/publish_cloudflare.sh <file_path> [port]
# Default file: /tmp/opencode/download/red_car_drift_reel.mp4
# Default port: 8765
#
# Requires: python3, cloudflared (both already installed on this server)
#
# Example:
#   ./scripts/publish_cloudflare.sh /tmp/opencode/reel_work/final_reel.mp4
#   -> prints: https://<random>.trycloudflare.com/final_reel.mp4

set -e

FILE="${1:-/tmp/opencode/download/red_car_drift_reel.mp4}"
PORT="${2:-8765}"

if [ ! -f "$FILE" ]; then
  echo "ERROR: File not found: $FILE"
  exit 1
fi

DIR="$(cd "$(dirname "$FILE")" && pwd)"
BASENAME="$(basename "$FILE")"

echo "Publishing: $FILE"
echo "Serving dir: $DIR on port $PORT"

# Kill anything already on this port
if command -v fuser >/dev/null 2>&1; then
  fuser -k "$PORT/tcp" 2>/dev/null || true
elif command -v lsof >/dev/null 2>&1; then
  lsof -ti:"$PORT" | xargs -r kill -9 2>/dev/null || true
fi
sleep 1

# Start local HTTP server (background)
cd "$DIR"
nohup python3 -m http.server "$PORT" > /tmp/opencode/http_publish.log 2>&1 &
HTTP_PID=$!

# Start cloudflared tunnel (background)
nohup cloudflared tunnel --url "http://localhost:$PORT" > /tmp/opencode/cloudflare_publish.log 2>&1 &
CF_PID=$!

# Wait for cloudflared to print the trycloudflare URL
sleep 8
URL="$(grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' /tmp/opencode/cloudflare_publish.log | tail -1)"

if [ -z "$URL" ]; then
  echo "ERROR: Could not extract cloudflared URL."
  echo "--- cloudflare log ---"
  cat /tmp/opencode/cloudflare_publish.log
  echo "--- http log ---"
  cat /tmp/opencode/http_publish.log
  exit 1
fi

echo ""
echo "============================================================"
echo "  PUBLIC DOWNLOAD LINK (mobile se khulega):"
echo "  $URL/$BASENAME"
echo "============================================================"
echo "HTTP server PID : $HTTP_PID"
echo "Cloudflared PID : $CF_PID"
echo "Logs            : /tmp/opencode/http_publish.log"
echo "                 : /tmp/opencode/cloudflare_publish.log"
echo ""
echo "Note: trycloudflare URLs are ephemeral (change each run)."
echo "      Re-run this command for a fresh link."
