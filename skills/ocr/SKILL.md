---
name: ocr
description: Extract text from images and screenshots with Tesseract OCR (English + Hindi out of the box). Use when the user wants text read from a screenshot, photo, scanned page, meme, UI capture, or any image, especially when the current model cannot see images ("Cannot read image (this model does not support image input)"). Returns the text verbatim as plain text or as word boxes with confidence. No API key, no vision model needed.
---

# OCR — read text from images / screenshots

Text-only models cannot *see* an image, but they can still read its text with
local Tesseract OCR. `ocr.py` pre-processes the image (grayscale, autocontrast,
upscale, sharpen), runs Tesseract with `eng+hin`, and prints the text verbatim.

## How to use

```bash
# Plain text (default: English + Hindi)
python3 "$HOME/.config/opencode/skill/ocr/ocr.py" /path/to/screenshot.png

# Same, via the short CLI alias installed by setup.sh
ocr /path/to/screenshot.png

# English only, full-page layout analysis
ocr --lang eng --psm 3 page.jpg

# Words with bounding boxes + confidence (JSON)
ocr --json shot.png

# Multiple images at once (each block gets a header)
ocr a.png b.png
```

Repo copy: `skills/ocr/ocr.py`; setup.sh installs the `~/.local/bin/ocr` alias.

## Options

- `--lang LANG` — Tesseract languages, default `eng+hin`. Add more with
  `sudo apt-get install tesseract-ocr-<code>` and list them joined by `+`.
- `--psm N` — page segmentation mode. Default `6` (single uniform block of
  text, best for screenshots); use `3` for a full document/page, `7` for a
  single line, `11` for sparse text.
- `--scale N` — resize factor. Default `auto` (2x for small images, 1x for
  large ones). Pass `1` to disable resizing.
- `--no-preprocess` — feed the original image to Tesseract.
- `--json` — emit words with `text`, `conf`, and `box` `[x, y, w, h]` instead
  of plain text (coordinates refer to the pre-processed image).

## Notes

- Installed by `setup.sh`: apt `tesseract-ocr`, `tesseract-ocr-eng`,
  `tesseract-ocr-hin`; pip `pytesseract==0.3.13` (Pillow is already present).
- OCR works on the pixels only: it cannot interpret icons, colours or layout
  meaning. If you need scene understanding (e.g. "where is the facecam?"), use
  the `image-vision` skill instead.
- For low-quality screenshots, try `--psm 11`, or crop to the text region with
  ImageMagick/ffmpeg first and OCR the crop.
- For videos, extract a frame first:
  `ffmpeg -ss 10 -i video.mp4 -frames:v 1 /tmp/opencode/frame.jpg`.
