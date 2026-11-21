---
name: image-vision
description: Image input support for any model. Use this whenever you need to actually SEE an image - screenshots, frame grids, video QA strips, memes, diagrams, charts, UI mockups - and the current model says "this model does not support image input" or "Cannot read image". Delegates to the free OpenCode vision-language model opencode/nemotron-3.5-super-vl-free via `vision.sh <path> [question]`, which attaches the image with `opencode run --file`. Also ships a browser upload server (`upload_server.py`) for when chat attachments never reach the server disk, plus an auto-watch inbox (`~/image-inbox`) with a `see` command that describes dropped images into `~/image-inbox/LAST_SEEN.md`. No API key needed. Also useful as a general second opinion on images.
---

# Image Vision (see images from any model)

The current model may be text-only: its `read` tool returns "Image read successfully"
followed by "this model does not support image input". That is a model capability
limit, not a broken image. Use this skill instead.

## How to use

From this skill's base directory:

```bash
bash vision.sh /path/to/image.jpg "Describe what you see and where the facecam is"
```

- First argument: image path (png/jpg/webp/gif).
- Remaining arguments: the question, free form.
- Optional env `VISION_MODEL=provider/model` to override the default
  (`opencode/nemotron-3.5-super-vl-free`, free).

The script runs `opencode run --model <vision-model> --file <image> <question>`,
so the image is attached in a vision-capable session and the answer comes back
as plain text you can act on. It works even when the calling model is text-only.

## When the image never arrives on disk

If a chat attachment produces "Cannot read image" and no new image file exists on
the server, use the built-in browser uploader:

```bash
python3 skills/image-vision/upload_server.py          # or: image-upload
# open http://localhost:8388/ in a browser, pick the image, click Upload
cat /tmp/opencode/vision_latest.txt                    # path of the last upload
bash vision.sh "$(cat /tmp/opencode/vision_latest.txt)" "Describe the image"
```

Env: `VISION_UPLOAD_PORT` (default 8388), `VISION_UPLOAD_DIR` (default
`/tmp/opencode/vision_uploads`). Stdlib only, no new packages. Setup.sh starts it
with `VISION_UPLOAD_DIR=/tmp/opencode/inbox`, so every browser upload is picked up
by `auto-vision-watch.sh` and described into `~/image-inbox/LAST_SEEN.md`
automatically. Run it manually in the background if it is not listening.

## Automatic "user sent an image in chat" workflow

Chat attachments are handed straight to the active model. If that model is
text-only, the harness replies `Cannot read image (this model does not support
image input)` and usually **no local file is kept** — so there is nothing to read
afterwards. Setup.sh installs complementary helpers for this case:

- `see` (symlink at `~/.local/bin/see`, script `see.sh`): prints a description of
  a given image path, or of the newest image found in `~/image-inbox`,
  `/tmp/opencode/inbox`, `~/Downloads` or `~/Pictures` (which includes the
  browser uploader's `VISION_UPLOAD_DIR` if configured to `/tmp/opencode/inbox`).
- `auto-vision-watch.sh`: a background watcher started by setup.sh. It notices
  new images in those folders, runs the VL model on them and appends the result
  to `~/image-inbox/LAST_SEEN.md`.

Agent procedure when the user says they sent an image (or you see the
`Cannot read image` error):

1. Run `cat ~/image-inbox/LAST_SEEN.md` — the watcher may already have described it.
2. Otherwise run `see` (no args) from the shell; it picks the newest image.
3. If no file exists, open `http://localhost:8388/` (browser upload server) or ask
   the user to save the image into `~/image-inbox` and say "done".
4. Never answer "I can't see images" without trying these steps first.

## Good prompts

- "Describe this image in detail. List all visible text/UI. If a streamer facecam
  overlay is visible, give its exact position as fractions x,y,w,h of the frame
  (origin top-left)."  ← best for clip framing / ortha-clipper `--cam`
- "Read every word in this screenshot and report it verbatim."
- "What is wrong with this UI? List concrete issues with positions."
- "Does this QA strip show burned-in captions and a hook box? Any clipping or
  overflow?"

## Notes

- The VL model bills to the OpenCode free tier; no API key or extra install needed.
- Default path when installed: `skills/image-vision/vision.sh` in the repo, copied
  to `~/.config/opencode/skill/image-vision/` by setup.sh (along with `see.sh`,
  `auto-vision-watch.sh` and `upload_server.py`).
- Watcher logs: `/tmp/opencode/image-vision-watch.log`; processed-image state:
  `/tmp/opencode/image-vision-seen.tsv`. Delete the state file to force a re-scan.
- `~/.config/opencode/opencode.json` also declares `modalities.input = ["text",
  "image"]` for `nemotron-3.5-super-vl-free`, so native image attachment works if
  you switch the whole session to that model.
- For videos, extract a frame first (`ffmpeg -ss 10 -i video.mp4 -frames:v 1 out.jpg`)
  or use the `sheet.jpg` / `*_qa.jpg` that ortha-clipper already produces.
