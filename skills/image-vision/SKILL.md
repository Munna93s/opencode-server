---
name: image-vision
description: Image input support for any model. Use this whenever you need to actually SEE an image - screenshots, frame grids, video QA strips, memes, diagrams, charts, UI mockups - and the current model says "this model does not support image input" or "Cannot read image". Delegates to the free OpenCode vision-language model opencode/nemotron-3.5-super-vl-free via `vision.sh <path> [question]`, which attaches the image with `opencode run --file`. No API key needed. Also useful as a general second opinion on images.
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
  to `~/.config/opencode/skill/image-vision/` by setup.sh.
- `~/.config/opencode/opencode.json` also declares `modalities.input = ["text",
  "image"]` for `nemotron-3.5-super-vl-free`, so native image attachment works if
  you switch the whole session to that model.
- For videos, extract a frame first (`ffmpeg -ss 10 -i video.mp4 -frames:v 1 out.jpg`)
  or use the `sheet.jpg` / `*_qa.jpg` that ortha-clipper already produces.
