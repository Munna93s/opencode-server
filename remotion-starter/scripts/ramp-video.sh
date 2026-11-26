#!/usr/bin/env bash
# Regenerate public/assets/videos/luxe-octane-ramped.mp4 from the source clip.
#
# Source: public/assets/videos/luxe-octane.mp4 (1440x2560 @ ~59.94fps, ~14.58s,
# 9:16 vertical, no audio). It is gitignored (*.mp4) and lives locally only.
#
# Speed ramp -> exactly 8.0s / 480 frames @ 60fps:
#   0.0s-2.5s (Hook)      : 1.8x  (source frames 0-270)
#   2.5s-6.0s (Main)      : 0.7x  (source frames 270-417)
#   6.0s-8.0s (Loop Exit) : 2.0x  (source frames 417-657)
#
# Why pre-ramp with ffmpeg instead of Remotion playbackRate segments:
# Remotion v4.0.547's OffthreadVideo does not advance its playhead when a
# component mounts mid-composition with `trimBefore`, so per-segment ramps
# produce black frames. Baking the ramp into one clip keeps it seamless.
set -euo pipefail

cd "$(dirname "$0")/.."
SRC="public/assets/videos/luxe-octane.mp4"
OUT="public/assets/videos/luxe-octane-ramped.mp4"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if [ ! -f "$SRC" ]; then
  echo "ERROR: $SRC not found. Place the source clip there first." >&2
  exit 1
fi

# Each segment's setpts drops/duplicates frames to the target rate.
ffmpeg -y -i "$SRC" -vf "trim=start_frame=0:end_frame=270,setpts=PTS/1.8" -an -r 60 "$TMP/rampA.mp4" 2>/dev/null
ffmpeg -y -i "$SRC" -vf "trim=start_frame=270:end_frame=417,setpts=PTS/0.7" -an -r 60 "$TMP/rampB.mp4" 2>/dev/null
ffmpeg -y -i "$SRC" -vf "trim=start_frame=417:end_frame=657,setpts=PTS/2" -an -r 60 "$TMP/rampC.mp4" 2>/dev/null

printf "file '%s'\n" "$TMP/rampA.mp4" "$TMP/rampB.mp4" "$TMP/rampC.mp4" > "$TMP/concat.txt"
ffmpeg -y -f concat -safe 0 -i "$TMP/concat.txt" -c copy -an -frames:v 480 "$OUT" 2>/dev/null

echo "Wrote $OUT"
ffprobe -v error -select_streams v:0 \
  -show_entries stream=codec_name,width,height,r_frame_rate,duration,nb_frames \
  -of default=noprint_wrappers=1 "$OUT"
