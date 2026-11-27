#!/usr/bin/env bash
# =============================================================================
# kaam.sh — Pehle check karega ki kaam ke liye kaunsi skills / tools / AI
#           pehle se install hain, phir related ko use karne ka rasta batayega.
#
# Usage:
#   ./scripts/kaam.sh "<aapka kam>"
#
# Udaharan:
#   ./scripts/kaam.sh "video se captioned 9:16 reel banayein"
#   ./scripts/kaam.sh "screenshot se Hindi+English text nikalein"
#   ./scripts/kaam.sh "face swap karke video banayein"
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TASK="${1:-}"

if [ -z "$TASK" ]; then
  echo "Kaam batayiye taaki main pehle skills / tools / AI check kar sakoon."
  echo
  echo "Usage: $0 '<aapka kam ka tareeka>'"
  echo
  echo "Udaharan:"
  echo "  $0 'video se captioned 9:16 reel banayein'"
  echo "  $0 'screenshot se text nikalein (English + Hindi)'"
  echo "  $0 'face swap karke short video banayein'"
  echo "  $0 'instagram page ka audit karein aur content plan banayein'"
  echo "  $0 'image se koi chart ya diagram samajhein'"
  exit 1
fi

TASK_LOWER="$(echo "$TASK" | tr '[:upper:]' '[:lower:]')"

echo "============================================================"
echo "  KAAM PRE-CHECK"
echo "  Kaam: $TASK"
echo "============================================================"
echo

# ---------------------------------------------------------------------------
# 1. Installed OpenCode skills (skills/ folder) — read SKILL.md frontmatter
# ---------------------------------------------------------------------------
echo "--- [1/4] Installed OpenCode Skills ---"
SKILL_COUNT=0
shopt -s nullglob
for sk in "$REPO_ROOT"/skills/*/; do
  [ -d "$sk" ] || continue
  name="$(basename "$sk")"
  skmd="$sk/SKILL.md"
  desc=""
  if [ -f "$skmd" ]; then
    desc="$(sed -n '/^description:/s/^description:[[:space:]]*//p' "$skmd" | head -1 | cut -c1-140)"
  fi
  SKILL_COUNT=$((SKILL_COUNT + 1))
  printf "  [SKILL] %-20s %s\n" "$name" "$desc"
done
shopt -u nullglob
echo "    Total skills: $SKILL_COUNT"
echo

# ---------------------------------------------------------------------------
# 2. CLI tools present on PATH
# ---------------------------------------------------------------------------
echo "--- [2/4] CLI Tools (PATH par maujood) ---"
for t in ffmpeg yt-dlp tesseract ollama opencode gh igos ocr image-upload see bun proto docker jq curl wget aria2 git; do
  if command -v "$t" >/dev/null 2>&1; then
    v="$($t --version 2>/dev/null | head -1 || $t -v 2>/dev/null | head -1 || echo "present")"
    echo "  [TOOL] $t  ->  $v"
  fi
done
echo

# ---------------------------------------------------------------------------
# 3. Useful Python/pip packages
# ---------------------------------------------------------------------------
echo "--- [3/4] Python / pip packages (chuninda) ---"
for p in yt-dlp pytesseract youtube_transcript_api instaloader gallery_dl instagram_growth_os faster_whisper; do
  mod="${p//-/_}"
  if python3 -c "import $mod" 2>/dev/null; then
    echo "  [PIP] $p  ->  installed"
  fi
done
echo

# ---------------------------------------------------------------------------
# 4. AI models (Ollama local + OpenCode default)
# ---------------------------------------------------------------------------
echo "--- [4/4] AI Models ---"
if command -v ollama >/dev/null 2>&1; then
  echo "  [OLLAMA] local models:"
  ollama list 2>/dev/null | tail -n +2 | while IFS= read -r line; do
    [ -n "$line" ] && echo "      - $line"
  done || true
else
  echo "  [OLLAMA] install nahi hai"
fi
if [ -f "$HOME/.config/opencode/opencode.json" ]; then
  echo "  [OPENCODE] default model: $(python3 -c "import json;print(json.load(open('$HOME/.config/opencode/opencode.json')).get('model','?'))" 2>/dev/null || echo "?")"
else
  echo "  [OPENCODE] config nahi mila"
fi
echo

# ---------------------------------------------------------------------------
# 5. Keyword -> related skill / tool / AI recommendation (Hinglish output)
# ---------------------------------------------------------------------------
echo "============================================================"
echo "  SIFARISH (Kaam ke liye related installed skill / tool / AI)"
echo "============================================================"
match=0
add_match() {
  match=1
  echo "  [$1] $2"
}

if echo "$TASK_LOWER" | grep -qE 'limit|quota|free model|unlimited|local model|api key|gemini|groq'; then
  add_match unlimited "Opt-in local OpenCode model (qwen2.5:7b, no key/rate-limit); default is opencode/big-pickle"
  add_match unlimited-vl "Unlimited local vision (qwen2.5vl:3b via Ollama REST), alias: unlimited-vl"
elif echo "$TASK_LOWER" | grep -qE 'reel|short|tiktok|9:16|caption|clip|shorts'; then
  add_match neonclipping "YouTube/Twitch/Kick link ya local MP4 se captioned 9:16 clip (app: http://127.0.0.1:8770, skills/neonclipping)"
  add_match ortha-clipper "Live stream ya VOD highlight (chat/audio spike), skills/ortha-clipper/clipper.py"
  add_match beyondgtaclips "Kisi bhi game (default GTA 6) ke clips, 5 styles, hook card, 9:16 reels"
  add_match opencut "Video editing editor (OpenCut-classic :3000, rewrite :5173/:8787)"
  add_match video-editing "AI video editing: color grade, speed, style transfer, trimming, effects"
elif echo "$TASK_LOWER" | grep -qE 'face|swap|deepfake|lip-sync|lip sync|colourise|background'; then
  add_match facefusion "Face swap, face restore, lip-sync, colourise, background-remove (facefusion venv)"
elif echo "$TASK_LOWER" | grep -qE 'image|foto|photo|generate|screenshot|meme|chart|diagram|dekhein|samajh'; then
  add_match image-vision "Image dekhna/samajhna (vision.sh: cloud VL -> local ollama/qwen2.5vl:3b fallback; unlimited-vl command)"
  add_match ocr "Image/screenshot se text nikalna (Tesseract eng+hin, ocr alias)"
  add_match comfyui "Image/video generation workflow (ComfyUI venv)"
  add_match opensora "Text/video-to-video generation (Open-Sora, CPU-only)"
elif echo "$TASK_LOWER" | grep -qE 'text|transcript|bolly|seo|hashtag|title|caption likhna|research'; then
  add_match creator-seo "Instagram/YouTube growth: hooks, titles, captions, hashtags, competitor research"
  add_match instagram-growth-os "Instagram Insights audit, hook/caption lint, content plan (igos CLI)"
elif echo "$TASK_LOWER" | grep -qE 'insta|instagram|audit|profile|plan|karousel|limits'; then
  add_match instagram-growth-os "Instagram audit / profile rubric / content plan (igos CLI)"
elif echo "$TASK_LOWER" | grep -qE 'video|edit|trim|color grade|speed|transition|effect'; then
  add_match video-editing "AI video editing via each::sense (color, speed, style, trim, effects)"
  add_match opencut "Manual video editing (OpenCut editor)"
  add_match neonclipping "Clip banana (neonclipping app)"
fi

if [ "$match" -eq 0 ]; then
  echo "  (Kisi specific skill se direct match nahi mila.)"
  echo "  Upar diye gaye kisi bhi installed skill/tool/AI ka use karke kam shuru kiya ja sakta hai."
fi

echo
echo "============================================================"
echo "  AAGA KYA KAREIN (Next steps)"
echo "============================================================"
echo "  1. Upar diye gaye related skill / tool / AI mein se select karein."
echo "  2. Main uska use karke aapka kam shuru kar dunga."
echo "  3. Agar koi zaroori skill/tool/AI install nahi hai, toh mujhe batayein —"
echo "     main setup.sh, requirements.txt aur skills/ update karke install karwa dunga"
echo "     aur phir GitHub (Munna93s/opencode-server) par push kar dunga."
echo "============================================================"
