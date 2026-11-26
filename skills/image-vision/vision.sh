#!/usr/bin/env bash
# See/analyze an image with a vision-language model.
# Works from ANY model, including models that say "this model does not support image input".
# Primary : free OpenCode cloud VL model (fast, but has a daily usage limit).
# Fallback: local Ollama qwen2.5vl:3b — no rate limit, works offline.
# Usage: vision.sh <image-path> [question ...]
set -uo pipefail
IMG="${1:?usage: vision.sh <image-path> [question ...]}"
shift || true
Q="$*"
if [ -z "$Q" ]; then
  Q="Describe this image in detail. List all visible text/UI. If a streamer facecam overlay is visible, give its exact position as fractions x,y,w,h of the frame (origin top-left)."
fi
if [ ! -f "$IMG" ]; then echo "image not found: $IMG" >&2; exit 1; fi

MODEL="${VISION_MODEL:-opencode/nemotron-3.5-super-vl-free}"
LOCAL_MODEL="${VISION_LOCAL_MODEL:-qwen2.5vl:3b}"
OLLAMA_URL="${OLLAMA_URL:-http://127.0.0.1:11434}"

local_vision() {
  if ! curl -fsS "$OLLAMA_URL/api/tags" >/dev/null 2>&1; then
    nohup ollama serve >/tmp/opencode/ollama.log 2>&1 &
    for _ in $(seq 1 20); do
      curl -fsS "$OLLAMA_URL/api/tags" >/dev/null 2>&1 && break
      sleep 1
    done
  fi
  python3 - "$IMG" "$Q" "$LOCAL_MODEL" "$OLLAMA_URL" <<'PY'
import base64, json, sys, urllib.request
img, question, model, url = sys.argv[1:5]
with open(img, 'rb') as f:
    b64 = base64.b64encode(f.read()).decode()
payload = json.dumps({
    "model": model,
    "prompt": question,
    "images": [b64],
    "stream": False,
}).encode()
req = urllib.request.Request(
    url.rstrip('/') + '/api/generate',
    data=payload,
    headers={'Content-Type': 'application/json'},
)
with urllib.request.urlopen(req, timeout=600) as r:
    print(json.load(r).get('response', '').strip())
PY
}

if [ "${VISION_LOCAL_ONLY:-0}" = "1" ]; then
  local_vision
  exit $?
fi

if OUT=$(opencode run --model "$MODEL" --file "$IMG" "$Q" 2>&1); then
  printf '%s\n' "$OUT"
  exit 0
fi

echo "vision.sh: cloud VL unavailable -> using local Ollama $LOCAL_MODEL" >&2
printf '%s\n' "$OUT" | grep -iE 'limit|permission|denied|error' | head -2 >&2 || true
local_vision
