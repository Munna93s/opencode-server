#!/usr/bin/env bash
# see.sh — describe an image with the free OpenCode vision-language model.
# Works from ANY (even text-only) model: the image is handed to
# opencode/nemotron-3.5-super-vl-free via the local `opencode` CLI.
#
# Usage:
#   see                       # describe the newest image in the watch folders
#   see /path/to/photo.jpg    # describe a specific image
#   see /path/to/photo.jpg "Read every word in this screenshot"
set -euo pipefail

SKILL_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
INBOX="${IMAGE_INBOX:-$HOME/image-inbox}"

IMG=""
if [ $# -gt 0 ] && [ -f "$1" ]; then
  IMG="$1"
  shift
fi

if [ -z "$IMG" ]; then
  IMG="$(
    find "$INBOX" /tmp/opencode/inbox "$HOME/Downloads" "$HOME/Pictures" \
      -maxdepth 2 -type f \
      \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' \) \
      -printf '%T@ %p\n' 2>/dev/null \
      | sort -nr | head -n 1 | cut -d' ' -f2-
  )"
fi

if [ -z "$IMG" ] || [ ! -f "$IMG" ]; then
  echo "No image found. Drop one into $INBOX (or /tmp/opencode/inbox) and run 'see' again." >&2
  exit 1
fi

echo "# image: $IMG" >&2
"$SKILL_DIR/vision.sh" "$IMG" "$@" 2>&1 \
  | sed -r 's/\x1B\[[0-9;]*[mK]//g' \
  | grep -v '^> build'
