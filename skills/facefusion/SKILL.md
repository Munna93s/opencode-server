---
name: facefusion
description: Use the locally installed FaceFusion 3.9.2 on this server to swap faces, restore/enhance faces, lip-sync, colourise or background-remove images and videos. Covers the isolated venv, the corrected installer command, model download, headless runs and the Gradio web UI. Use when the user asks to run FaceFusion, swap/change a face in a photo or video, enhance old footage, lip-sync, or says "facefusion", "face swap", "deep swap", "face restore".
---

# FaceFusion (local install)

FaceFusion lives at `./facefusion/` in the repo root (git-ignored, recreated by
`setup.sh` step [6/7]). Its dependencies are in `./facefusion/venv` — **never**
install them system-wide: they pin `numpy==2.5.4`, `onnxruntime==1.31.0`,
`pillow==11.3.0` and `gradio==5.50.0`, which would break the server toolchain.

Use only with the consent of the people depicted and with content you have the
rights to edit.

## Paths

- App: `./facefusion/facefusion.py`
- Python: `./facefusion/venv/bin/python`
- Pins: `./requirements-facefusion.txt`

From the repo root, every command looks like:

```bash
./facefusion/venv/bin/python ./facefusion/facefusion.py <command> [options]
```

## Verify / diagnose

```bash
./facefusion/venv/bin/python ./facefusion/facefusion.py --version   # FaceFusion 3.9.2
./facefusion/venv/bin/python -c "import onnxruntime, cv2, gradio; print(onnxruntime.__version__, cv2.__version__, gradio.__version__)"
```

A harmless `onnxruntime` PCI-bus warning on this VM is normal.

## Models (already downloaded on this server)

All models are present in `facefusion/.assets` — **39 GB, 242 files**. They are
git-ignored along with the rest of the clone and are not pushed to GitHub.

`install.py` only installs Python packages; models are fetched on demand or all
at once. To reproduce the full cache on a fresh machine (check free disk first):

```bash
cd facefusion && PATH="$PWD/venv/bin:$PATH" ./venv/bin/python facefusion.py force-download
```

Or set `FACEFUSION_DOWNLOAD_MODELS=1` when running `setup.sh`, which makes step
[6/6] do this automatically. It is opt-in because of the size.

## Headless run (image or video)

```bash
./facefusion/venv/bin/python ./facefusion/facefusion.py headless-run \
  -s /path/to/source_face.jpg \
  -t /path/to/target.mp4 \
  -o /path/to/output.mp4
```

Use `run` instead of `headless-run` to open the Gradio web UI. Useful options:
`--processors face_swapper face_enhancer`, `--face-swapper-model inswapper_128`,
`--output-video-encoder libx264`, `--output-video-quality 80`,
`--trim-frame-start`, `--trim-frame-end`. Run
`... facefusion.py run --help` for the full current list.

Generated videos are excluded from git by `.gitignore` (`*.mp4`, `*.zip`, …).

## Reinstalling / fixing the environment

Current FaceFusion uses a **positional** onnxruntime argument and requires
conda unless skipped:

```bash
cd facefusion
PATH="$PWD/venv/bin:$PATH" ./venv/bin/python install.py default --skip-conda
```

The `PATH=` prefix is essential: `install.py` resolves `pip` with
`shutil.which('pip')`, so activating the venv is not enough — without the
prefix it installs into `~/.local` and downgrades the system `pillow`.

Other valid runtime choices: `cuda@12`, `cuda@13`, `openvino`, `migraphx`,
`rocm` (Linux); `default` is CPU-only. Add `--force-reinstall` if needed.
