#!/usr/bin/env python3
"""OCR text out of images/screenshots with local Tesseract (English + Hindi).

Usage:
    ocr.py IMAGE [IMAGE ...] [--lang eng+hin] [--psm 6] [--json]
"""
from __future__ import annotations

import argparse
import json
import shutil
import sys
from pathlib import Path

try:
    import pytesseract
    from PIL import Image, ImageFilter, ImageOps
except ImportError as exc:  # pragma: no cover - depends on the host toolchain
    print(
        f"OCR dependency missing: {exc}. Install with: "
        "sudo apt-get install -y tesseract-ocr tesseract-ocr-eng tesseract-ocr-hin "
        "&& python3 -m pip install --break-system-packages pytesseract==0.3.13",
        file=sys.stderr,
    )
    raise SystemExit(2)


def prepare(image: Image.Image, scale: float) -> Image.Image:
    """Normalise a screenshot so Tesseract gets larger, high-contrast text."""
    image = ImageOps.exif_transpose(image).convert("L")
    if scale and scale != 1:
        w, h = image.size
        image = image.resize(
            (max(1, int(w * scale)), max(1, int(h * scale))),
            Image.Resampling.LANCZOS,
        )
    image = ImageOps.autocontrast(image, cutoff=1)
    return image.filter(ImageFilter.UnsharpMask(radius=1, percent=150, threshold=3))


def auto_scale(image: Image.Image) -> float:
    w, h = image.size
    return 2.0 if w < 1600 and h < 1200 else 1.0


def ocr_file(path: Path, args: argparse.Namespace) -> str:
    with Image.open(path) as raw:
        raw.load()
        scale = args.scale if args.scale is not None else auto_scale(raw)
        image = raw if args.no_preprocess else prepare(raw, scale)
        if args.no_preprocess:
            image = image.convert("RGB")

        config = f"--psm {args.psm}"
        if args.json:
            data = pytesseract.image_to_data(
                image, lang=args.lang, config=config,
                output_type=pytesseract.Output.DICT,
            )
            words = []
            for i, word in enumerate(data["text"]):
                word = word.strip()
                if not word:
                    continue
                try:
                    conf = float(data["conf"][i])
                except (TypeError, ValueError):
                    conf = -1.0
                words.append({
                    "text": word,
                    "conf": round(conf, 1),
                    "box": [data["left"][i], data["top"][i],
                            data["width"][i], data["height"][i]],
                })
            return json.dumps(words, ensure_ascii=False, indent=2)

        return pytesseract.image_to_string(image, lang=args.lang, config=config).strip()


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Read text from images/screenshots using Tesseract OCR."
    )
    parser.add_argument("images", nargs="+", type=Path, help="image file(s) to read")
    parser.add_argument("--lang", default="eng+hin",
                        help="Tesseract language codes joined by '+' (default: eng+hin)")
    parser.add_argument("--psm", type=int, default=6,
                        help="page segmentation mode (default: 6, single text block)")
    parser.add_argument("--scale", type=float, default=None,
                        help="resize factor; default auto (2x for small images)")
    parser.add_argument("--no-preprocess", action="store_true",
                        help="use the original image without enhancement")
    parser.add_argument("--json", action="store_true",
                        help="output words with confidence and bounding boxes")
    args = parser.parse_args()

    if shutil.which("tesseract") is None:
        print("tesseract binary not found. Install: sudo apt-get install -y "
              "tesseract-ocr tesseract-ocr-eng tesseract-ocr-hin", file=sys.stderr)
        return 2

    failed = False
    for index, path in enumerate(args.images):
        if not path.is_file():
            print(f"ERROR: no such file: {path}", file=sys.stderr)
            failed = True
            continue
        if len(args.images) > 1 and not args.json:
            print(f"===== {path} =====")
        try:
            text = ocr_file(path, args)
        except Exception as exc:
            print(f"ERROR reading {path}: {exc}", file=sys.stderr)
            failed = True
            continue
        if text:
            print(text)
        elif len(args.images) > 1 and not args.json:
            print("(no text detected)")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
