#!/usr/bin/env bash
set -euo pipefail

# Free/open-source creator research tools for YouTube & Instagram SEO/support.
# - youtube-transcript-api: fetch YouTube transcripts/captions for hooks, keywords, summaries
# - instaloader: inspect/download public Instagram profile/post metadata & media (where allowed)
# - gallery-dl: download/extract media & metadata from supported sites for research/clipping
#
# Safe to re-run.

if [ "$(id -u)" -eq 0 ]; then
  PIP_FLAGS=(--break-system-packages)
else
  PIP_FLAGS=(--break-system-packages)
fi

python3 -m pip install "${PIP_FLAGS[@]}" --upgrade \
  youtube-transcript-api \
  instaloader \
  gallery-dl \
  defusedxml

echo "==> creator tools installed:"
python3 -m pip show youtube-transcript-api instaloader gallery-dl 2>/dev/null | awk '/^(Name|Version):/{print "  "$0}' || true
command -v instaloader >/dev/null 2>&1 && echo "  instaloader: $(command -v instaloader)" || true
command -v gallery-dl >/dev/null 2>&1 && echo "  gallery-dl: $(command -v gallery-dl)" || true
python3 -c "import youtube_transcript_api; print('  youtube-transcript-api: import ok')" 2>/dev/null || true
