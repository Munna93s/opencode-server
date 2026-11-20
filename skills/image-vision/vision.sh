#!/usr/bin/env bash
# See/analyze an image with the free OpenCode vision-language model.
# Works from ANY model, including models that say "this model does not support image input".
# Usage: vision.sh <image-path> [question ...]
set -euo pipefail
IMG="${1:?usage: vision.sh <image-path> [question ...]}"
shift || true
Q="$*"
if [ -z "$Q" ]; then
  Q="Describe this image in detail. List all visible text/UI. If a streamer facecam overlay is visible, give its exact position as fractions x,y,w,h of the frame (origin top-left)."
fi
if [ ! -f "$IMG" ]; then echo "image not found: $IMG" >&2; exit 1; fi
MODEL="${VISION_MODEL:-opencode/nemotron-3.5-super-vl-free}"
exec opencode run --model "$MODEL" --file "$IMG" "$Q"
