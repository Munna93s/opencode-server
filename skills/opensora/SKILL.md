---
name: opensora
description: Use the locally installed Open-Sora on this server. Covers the isolated venv, running text-to-video/image-to-video inference, CPU-only limits, and model weights download. Use when the user asks to install/use Open-Sora or generate video from a prompt.
---

# Open-Sora (local install)

Open-Sora (hpcaitech/Open-Sora) is a free, open-source text-to-video / image-to-video
diffusion model. It lives in `./Open-Sora/` in the repo root (git-ignored, recreated by
`setup.sh`). Its Python dependencies live in `./Open-Sora/.venv` — never install them
system-wide: `colossalai`, `torch`, `av`, `liger-kernel` etc. clash with the global
toolchain and with FaceFusion / ComfyUI / NeonClipping.

## Environment notes (read before use)

- **This VM has no NVIDIA GPU.** Open-Sora is designed for CUDA. On CPU it is
  usable only for setup / tiny test generations; rendering even a 2-second clip can
  take many minutes and may OOM. Do not expect real-time or production output here.
- **Python is 3.14.4**, newer than what upstream Open-Sora was validated against.
  Its `setup.py` pins `torch==2.4.0` and `av==13.1.0`, neither of which builds here.
  `setup.sh` therefore installs CPU torch from PyTorch's CPU wheel index, bumps
  `av` to `>=14`, and installs `colossalai --no-deps` + `psutil`. The package imports
  and the inference import chain work, but upstream training/inference scripts may
  still hit version issues.
- Model weights (~11B parameters, several GB) are **not** downloaded by `setup.sh`.
  Download them on demand from Hugging Face (`hpcai-tech/Open-Sora-v2`) or ModelScope.

## Paths

- Repo: `./Open-Sora/`
- Python: `./Open-Sora/.venv/bin/python`
- Inference script: `./Open-Sora/scripts/diffusion/inference.py`
- Configs: `./Open-Sora/configs/diffusion/inference/`
- Output samples: `./Open-Sora/samples/`

## Verify / diagnose

```bash
./Open-Sora/.venv/bin/python -c \
  "import opensora, torch, colossalai, av, omegaconf, accelerate; print('opensora imports OK')"
./Open-Sora/.venv/bin/python -c "from colossalai.utils import set_seed; print('inference chain OK')"
```

## Download model weights

Weights live on Hugging Face: https://huggingface.co/hpcai-tech/Open-Sora-v2

Install the HF CLI and download (run once, several GB):

```bash
./Open-Sora/.venv/bin/python -m pip install "huggingface_hub[cli]"
./Open-Sora/.venv/bin/huggingface-cli download hpcai-tech/Open-Sora-v2 \
  --local-dir ./Open-Sora/checkpoints/Open-Sora-v2
```

Then point inference at `--model-path ./Open-Sora/checkpoints/Open-Sora-v2` (adjust to
match the actual checkpoint layout after download).

## Run text-to-video inference

From the repo root (CPU-only; expect very slow / small test only):

```bash
./Open-Sora/.venv/bin/python ./Open-Sora/scripts/diffusion/inference.py \
  ./Open-Sora/configs/diffusion/inference/256px.py \
  --save-dir ./Open-Sora/samples \
  --prompt "raining, sea" \
  --model-path ./Open-Sora/checkpoints/Open-Sora-v2
```

For image-to-video, use `--cond_type i2v_head --ref <image.png>` with a matching config.

## Reinstalling / fixing the environment

```bash
./Open-Sora/.venv/bin/python -m pip install --upgrade pip wheel setuptools
./Open-Sora/.venv/bin/python -m pip install torch torchvision \
  --index-url https://download.pytorch.org/whl/cpu
./Open-Sora/.venv/bin/python -m pip install -e ./Open-Sora --no-deps
```
