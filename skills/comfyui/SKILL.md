---
name: comfyui
description: Use the locally installed ComfyUI on this server to run image/video generation workflows through its node UI or API. Covers the isolated venv, starting the server, model folders, headless API workflow submission and CPU-only operation. Use when the user asks to run ComfyUI, start its web UI, generate images/videos with a ComfyUI workflow, or says "ComfyUI", "comfy", "run this workflow".
---

# ComfyUI (local install)

ComfyUI lives at `./ComfyUI/` in the repo root (git-ignored, recreated by
`setup.sh` step [7/7]). Its dependencies are in `./ComfyUI/venv` — **never**
install them system-wide: they pull `torch`, `torchvision` and a different
`numpy`/`Pillow` stack that would break the server toolchain.

This VM has no NVIDIA GPU, so runs are CPU-only unless the user provides a GPU
host. Expect slow generations and use small workflows/resolutions.

## Paths

- App: `./ComfyUI/main.py`
- Python: `./ComfyUI/venv/bin/python`
- Pins: `./requirements-comfyui.txt`
- Models: `./ComfyUI/models/` (`checkpoints`, `loras`, `vae`, `controlnet`, …)
- Inputs/outputs: `./ComfyUI/input/`, `./ComfyUI/output/`

No model weights are downloaded by `setup.sh`. Place `.safetensors` files in the
matching `models/` subfolder before running a workflow.

## Verify / diagnose

```bash
./ComfyUI/venv/bin/python ./ComfyUI/main.py --help
(cd ComfyUI && venv/bin/python -c "import torch, comfy; print(torch.__version__)")
```

## Start the web UI

From the repo root:

```bash
nohup ./ComfyUI/venv/bin/python ./ComfyUI/main.py --listen 0.0.0.0 --port 8188 --cpu > /tmp/comfyui.log 2>&1 &
```

Then open `http://localhost:8188`. Omit `--cpu` only on a host with a supported
GPU. Useful flags: `--port 8189` to avoid a clash, `--reserve-vram <GB>`,
`--fp16-unet` / `--bf16-unet` on supported GPUs, `--disable-xformers`.

## Submit a workflow without the UI

ComfyUI exposes a local HTTP API on the same port:

```bash
curl -s http://127.0.0.1:8188/prompt \
  -H 'Content-Type: application/json' \
  -d '{"prompt": <workflow_json>, "client_id": "opencode"}'
```

Use `/history`, `/queue` and `/view?filename=...&type=output` to inspect results.
Generated images/videos stay under `./ComfyUI/output/` and large binaries are
excluded from git by `.gitignore`.

## Reinstalling / fixing the environment

```bash
./ComfyUI/venv/bin/python -m pip install -r requirements-comfyui.txt
```

The upstream, unpinned list is kept at `./ComfyUI/requirements.txt`; the pinned
file in the repo root is the reproducible snapshot used by `setup.sh`.
