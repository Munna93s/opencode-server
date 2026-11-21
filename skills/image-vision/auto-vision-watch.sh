#!/usr/bin/env bash
# auto-vision-watch.sh — background watcher for newly dropped images.
#
# Watches the image inbox (and common download folders). When a new image
# appears it is described by the free OpenCode VL model and the result is
# written to ~/image-inbox/LAST_SEEN.md, so a text-only agent can just read
# that file and "see" the image.
set -uo pipefail

SKILL_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
INBOX="${IMAGE_INBOX:-$HOME/image-inbox}"
WATCH_DIRS=("$INBOX" /tmp/opencode/inbox "$HOME/Downloads" "$HOME/Pictures")
STATE="${IMAGE_VISION_STATE:-/tmp/opencode/image-vision-seen.tsv}"
LAST="$INBOX/LAST_SEEN.md"
LOG="${IMAGE_VISION_LOG:-/tmp/opencode/image-vision-watch.log}"
QUESTION="Describe this image in detail. List all visible text/UI verbatim. If a person is visible, describe face, expression, clothing and pose. If this is a screenshot or QA strip, say what it shows and flag any clipping or overflow."

mkdir -p "$INBOX" /tmp/opencode/inbox "$HOME/Downloads" "$HOME/Pictures" 2>/dev/null || true
mkdir -p "$(dirname "$STATE")" "$(dirname "$LOG")" 2>/dev/null || true
touch "$STATE" "$LOG" "$LAST" 2>/dev/null || true

collect() {
  for d in "${WATCH_DIRS[@]}"; do
    [ -d "$d" ] || continue
    find "$d" -maxdepth 2 -type f \
      \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \
         -o -iname '*.gif' -o -iname '*.bmp' \) \
      -printf '%T@|%p\n' 2>/dev/null
  done
}

# First run: remember what is already there so old files are not re-described.
if [ ! -s "$STATE" ]; then
  collect | while IFS='|' read -r mt path; do printf '%s|%s\n' "$mt" "$path" >> "$STATE"; done
  echo "$(date -u +%FT%TZ) seeded $(wc -l < "$STATE") existing image(s)" >> "$LOG"
fi

echo "$(date -u +%FT%TZ) image-vision watcher started (pid $$)" >> "$LOG"

while true; do
  collect | while IFS='|' read -r mt path; do
    key="$mt|$path"
    grep -qF -- "$key" "$STATE" && continue
    printf '%s\n' "$key" >> "$STATE"
    echo "$(date -u +%FT%TZ) new image: $path" >> "$LOG"
    desc="$(timeout 240 "$SKILL_DIR/vision.sh" "$path" "$QUESTION" 2>&1 \
      | sed -r 's/\x1B\[[0-9;]*[mK]//g' | grep -v '^> build')" || desc="ERROR: $desc"
    {
      echo "## $(date -u +%FT%TZ) — $(basename "$path")"
      echo "path: $path"
      echo
      echo "$desc"
      echo
      echo "---"
      echo
    } >> "$LAST"
    echo "$(date -u +%FT%TZ) described: $path -> $LAST" >> "$LOG"
  done
  sleep 3
done
