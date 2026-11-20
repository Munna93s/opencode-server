#!/usr/bin/env bash
# =============================================================================
# setup.sh — reproduce the toolchain captured from the OpenCode cloud server
# Generated : 2026-11-19 22:25:48
# Source    : /home/runner/work/opencode-server/opencode-server
# Contents  : apt packages, pip packages, npm globals, pipx tools, OpenCode skills, OpenCut editors
# Usage     : bash setup.sh            (run as root, or via sudo)
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUDO=""
if [ "$(id -u)" -ne 0 ]; then SUDO="sudo"; fi

echo "==> [1/7] apt: updating package index"
$SUDO apt-get update -y

echo "==> [2/7] apt: installing 245 manually-installed packages"
if ! $SUDO apt-get install -y --no-install-recommends \
  7zip \
  7zip-rar \
  acl \
  ant \
  ant-optional \
  apache2 \
  apt \
  apt-transport-https \
  aria2 \
  autoconf \
  automake \
  azure-cli \
  azure-vm-utils \
  bash \
  bind9-dnsutils \
  binutils \
  bison \
  brotli \
  buildah \
  bzip2 \
  ca-certificates \
  cifs-utils \
  clang-20 \
  clang-21 \
  clang-22 \
  clang-format-20 \
  clang-format-21 \
  clang-format-22 \
  clang-tidy-20 \
  clang-tidy-21 \
  clang-tidy-22 \
  cloud-guest-utils \
  cloud-init \
  cloud-init-base \
  containerd.io \
  coreutils \
  curl \
  dash \
  dbus \
  diffutils \
  docker-ce \
  docker-ce-cli \
  dpkg \
  dpkg-dev \
  eatmydata \
  efibootmgr \
  fakeroot \
  fdisk \
  ffmpeg \
  file \
  findutils \
  firefox \
  flex \
  fonts-noto-color-emoji \
  ftp \
  g++ \
  g++-13 \
  g++-14 \
  g++-15 \
  gcc \
  gdisk \
  gfortran \
  gfortran-13 \
  gfortran-14 \
  gfortran-15 \
  gh \
  git-ftp \
  git-lfs \
  gnupg \
  gnupg2 \
  google-chrome-stable \
  google-cloud-cli \
  grep \
  grub-pc \
  gzip \
  hostname \
  init \
  iproute2 \
  iputils-ping \
  jq \
  keyutils \
  kubectl \
  libc6 \
  libcrypt-dev \
  libeatmydata1 \
  libgcc-s1 \
  libgmp-dev \
  libgssapi-krb5-2 \
  libicu-dev \
  libicu78 \
  libjitterentropy3-dev \
  libjs-sphinxdoc \
  liblttng-ust1t64 \
  liblz4-dev \
  libmysqlclient-dev \
  libnss3-tools \
  libpq-dev \
  libsqlite3-dev \
  libssl-dev \
  libssl3t64 \
  libstdc++6 \
  libtool \
  libtss2-esys-3.0.2-0t64 \
  libtss2-mu-4.0.1-0t64 \
  libtss2-rc0t64 \
  libwrap0 \
  libxtst6 \
  libyaml-dev \
  linux-azure \
  linux-base \
  lld-20 \
  lld-21 \
  lld-22 \
  lldb-21 \
  locales \
  lsb-release \
  lsscsi \
  lz4 \
  m4 \
  make \
  microsoft-edge-stable \
  mysql-client \
  mysql-server \
  ncurses-base \
  ncurses-bin \
  ncurses-term \
  net-tools \
  nftables \
  nginx \
  nvme-cli \
  openssh-client \
  openssh-server \
  openssh-sftp-server \
  openssl \
  packages-microsoft-prod \
  parallel \
  patchelf \
  php-pear \
  php8.5 \
  php8.5-amqp \
  php8.5-apcu \
  php8.5-bcmath \
  php8.5-bz2 \
  php8.5-cgi \
  php8.5-cli \
  php8.5-common \
  php8.5-curl \
  php8.5-dba \
  php8.5-dev \
  php8.5-enchant \
  php8.5-fpm \
  php8.5-gd \
  php8.5-gmp \
  php8.5-igbinary \
  php8.5-imagick \
  php8.5-interbase \
  php8.5-intl \
  php8.5-ldap \
  php8.5-mbstring \
  php8.5-memcache \
  php8.5-memcached \
  php8.5-mongodb \
  php8.5-mysql \
  php8.5-odbc \
  php8.5-pcov \
  php8.5-pgsql \
  php8.5-phpdbg \
  php8.5-pspell \
  php8.5-readline \
  php8.5-redis \
  php8.5-snmp \
  php8.5-soap \
  php8.5-sqlite3 \
  php8.5-sybase \
  php8.5-tidy \
  php8.5-xdebug \
  php8.5-xml \
  php8.5-xsl \
  php8.5-yaml \
  php8.5-zip \
  php8.5-zmq \
  pigz \
  pkg-config \
  podman \
  pollinate \
  postgresql-18 \
  python-babel-localedata \
  python-is-python3 \
  python3 \
  python3-babel \
  python3-dev \
  python3-jinja2 \
  python3-json-pointer \
  python3-jsonpatch \
  python3-jsonschema \
  python3-jsonschema-specifications \
  python3-markupsafe \
  python3-passlib \
  python3-pip \
  python3-referencing \
  python3-rpds-py \
  python3-serial \
  python3-venv \
  rpm \
  rsync \
  ruby-full \
  session-manager-plugin \
  shellcheck \
  shim-signed \
  skopeo \
  snmp \
  software-properties-common \
  sqlite3 \
  ssh \
  ssh-import-id \
  sshpass \
  sudo \
  swig \
  sysstat \
  systemd-coredump \
  tar \
  telnet \
  temurin-11-jdk \
  temurin-17-jdk \
  temurin-21-jdk \
  temurin-25-jdk \
  texinfo \
  time \
  tk \
  tree \
  tzdata \
  ubuntu-minimal \
  ubuntu-server \
  ubuntu-standard \
  unzip \
  upx-ucl \
  util-linux \
  walinuxagent \
  wget \
  xvfb \
  xz-utils \
  zip \
  zlib1g \
  zlib1g-dev \
  zsync
then
  echo "WARNING: full apt set failed (external repos may be missing); installing essential subset." >&2
  $SUDO apt-get install -y --no-install-recommends \
    python3-pip python3-venv ffmpeg git git-lfs gh curl wget jq unzip zip \
    aria2 rsync parallel shellcheck tree || echo "WARN: essential apt install failed" >&2
fi

echo "==> [3/7] pip: installing 98 Python packages"
if ! python3 -m pip install --break-system-packages -r "$SCRIPT_DIR/requirements.txt"; then
  echo "WARNING: some pip packages failed to build (OS-provided ones are covered by apt)." >&2
fi

echo "==> [4/7] npm/pipx: installing global JS tools and Python CLI tools"
if ! npm install -g \
  @bazel/bazelisk@v1.28.1 \
  @opencode/cli@2.3.2 \
  bun@1.4.5 \
  cloudflared@0.7.3 \
  corepack@0.36.0 \
  n@11.0.0 \
  npm@11.19.1 \
  yarn@1.22.22
then
  echo "WARNING: npm global install failed; workflow fallback will retry essentials." >&2
fi
if ! command -v pipx >/dev/null 2>&1; then
  python3 -m pip install --break-system-packages pipx
  pipx ensurepath || true
fi
pipx install --force ansible-core==2.22.0 2>/dev/null || echo "WARN: pipx install ansible-core failed" >&2
pipx install --force yamllint==1.38.0 2>/dev/null || echo "WARN: pipx install yamllint failed" >&2

echo "==> [5/7] OpenCode skills: restoring from backup"
mkdir -p "$HOME/.config/opencode/skill"
if [ -d "$SCRIPT_DIR/skills" ]; then
  cp -a "$SCRIPT_DIR/skills/." "$HOME/.config/opencode/skill/"
  echo "    restored: $(find "$SCRIPT_DIR/skills" -name SKILL.md | wc -l) skill(s)"
fi
# Beyond GTA Clips: private venv + Whisper/face models (~220 MB) under
# ~/.beyondgtaclips. Re-running is safe; downloads are cached. Keeps the
# skill's heavy deps out of the system Python.
BGC_SETUP="$SCRIPT_DIR/skills/beyondgtaclips/scripts/setup_env.py"
if [ -f "$BGC_SETUP" ]; then
  python3 "$BGC_SETUP" || echo "WARNING: beyondgtaclips setup failed" >&2
fi
# YouTube's PO-token bot check needs the bgutil provider server (datacenter IPs).
# Start it on loopback when Docker is available; harmless otherwise.
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  if ! docker ps --format '{{.Names}}' 2>/dev/null | grep -qx bgutil-provider; then
    docker rm -f bgutil-provider >/dev/null 2>&1 || true
    docker run --name bgutil-provider -d --init \
      -p 127.0.0.1:4416:4416 brainicism/bgutil-ytdlp-pot-provider >/dev/null 2>&1 \
      || echo "WARNING: bgutil PO-token provider failed to start" >&2
  fi
fi
# Ortha Clipper: keeps a rolling live-stream buffer and cuts chat/audio spike
# moments while a stream is still live. Its PEP 723 script deps (yt-dlp,
# faster-whisper, pillow, numpy, imageio-ffmpeg) are installed by uv into its
# own cache; prewarm them here so live clipping starts without a delay.
ORTHA_SCRIPT="$SCRIPT_DIR/skills/ortha-clipper/clipper.py"
if [ -f "$ORTHA_SCRIPT" ] && command -v uv >/dev/null 2>&1; then
  uv run --script "$ORTHA_SCRIPT" --help >/dev/null 2>&1 \
    || echo "WARNING: ortha-clipper dependency prewarm failed" >&2
fi
# Image vision: let any (even text-only) model actually see images by delegating
# to the free OpenCode VL model. No API key or extra package needed. Declare
# image input for that model so native --file / Read attachment works too.
VISION_SH="$SCRIPT_DIR/skills/image-vision/vision.sh"
if [ -f "$VISION_SH" ]; then
  chmod +x "$VISION_SH"
  python3 - <<'PY' || echo "WARNING: vision modalities config failed" >&2
import json, pathlib
p = pathlib.Path.home() / ".config/opencode/opencode.json"
try:
    cfg = json.loads(p.read_text()) if p.exists() else {}
except Exception:
    cfg = {}
mods = cfg.setdefault("provider", {}).setdefault("opencode", {}).setdefault("models", {}).setdefault("nemotron-3.5-super-vl-free", {})
mods["name"] = "Nemotron 3.5 Super VL Free"
mods["modalities"] = {"input": ["text", "image"], "output": ["text"]}
p.parent.mkdir(parents=True, exist_ok=True)
p.write_text(json.dumps(cfg, indent=2) + "\n")
PY
fi

echo "==> [6/7] FaceFusion 3.9.2: isolated clone + venv"
# FaceFusion pins numpy/onnxruntime/pillow/gradio versions that clash with the
# global toolchain, so it lives in ./facefusion/venv and is never pip-installed
# system-wide. See skills/facefusion/SKILL.md.
FACEFUSION_DIR="$SCRIPT_DIR/facefusion"
if [ ! -d "$FACEFUSION_DIR/.git" ]; then
  git clone --depth 1 https://github.com/facefusion/facefusion.git "$FACEFUSION_DIR" \
    || echo "WARNING: FaceFusion clone failed" >&2
fi
if [ -d "$FACEFUSION_DIR" ]; then
  if [ ! -x "$FACEFUSION_DIR/venv/bin/python" ]; then
    python3 -m venv "$FACEFUSION_DIR/venv" \
      || echo "WARNING: FaceFusion venv creation failed" >&2
  fi
  if [ -x "$FACEFUSION_DIR/venv/bin/python" ]; then
    # The installer resolves `pip` from PATH, NOT from the interpreter that
    # runs it. Prepending the venv bin dir is required or deps land in ~/.local.
    (
      cd "$FACEFUSION_DIR"
      PATH="$PWD/venv/bin:$PATH" ./venv/bin/python install.py default --skip-conda
      # All models are ~39 GB / 242 files. Opt in with
      # FACEFUSION_DOWNLOAD_MODELS=1 so a normal setup.sh run stays fast;
      # otherwise models are fetched on first use, or via the documented command.
      if [ "${FACEFUSION_DOWNLOAD_MODELS:-0}" = "1" ]; then
        PATH="$PWD/venv/bin:$PATH" ./venv/bin/python facefusion.py force-download \
          || echo "WARNING: FaceFusion model download failed" >&2
      fi
    ) || echo "WARNING: FaceFusion dependency install failed" >&2
  fi
fi

echo "==> [7/7] ComfyUI: isolated clone + venv"
# ComfyUI pulls torch/torchvision and a conflicting numpy/Pillow stack, so it
# gets its own venv instead of touching the global toolchain. See
# skills/comfyui/SKILL.md for usage.
COMFYUI_DIR="$SCRIPT_DIR/ComfyUI"
if [ ! -d "$COMFYUI_DIR/.git" ]; then
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git "$COMFYUI_DIR" \
    || echo "WARNING: ComfyUI clone failed" >&2
fi
if [ -d "$COMFYUI_DIR" ]; then
  if [ ! -x "$COMFYUI_DIR/venv/bin/python" ]; then
    python3 -m venv "$COMFYUI_DIR/venv" \
      || echo "WARNING: ComfyUI venv creation failed" >&2
  fi
  if [ -x "$COMFYUI_DIR/venv/bin/python" ]; then
    "$COMFYUI_DIR/venv/bin/python" -m pip install --upgrade pip wheel setuptools \
      || echo "WARNING: ComfyUI pip upgrade failed" >&2
    "$COMFYUI_DIR/venv/bin/python" -m pip install -r "$SCRIPT_DIR/requirements-comfyui.txt" \
      || echo "WARNING: ComfyUI dependency install failed" >&2
  fi
fi

echo "==> OpenCut editors: classic (working) + rewrite (in development)"
# proto installs the tool versions pinned in OpenCut/.prototools (moon, bun, rust).
# bun itself is installed as an npm global in step [4/7] above.
if ! command -v proto >/dev/null 2>&1; then
  bash <(curl -fsSL https://moonrepo.dev/install/proto.sh) \
    || echo "WARNING: proto install failed" >&2
fi
export PATH="$HOME/.proto/bin:$PATH"

OPENCUT_DIR="$SCRIPT_DIR/OpenCut"
CLASSIC_DIR="$SCRIPT_DIR/OpenCut-classic"
if [ ! -d "$OPENCUT_DIR/.git" ]; then
  git clone --depth 1 https://github.com/OpenCut-app/OpenCut.git "$OPENCUT_DIR" \
    || echo "WARNING: OpenCut rewrite clone failed" >&2
fi
if [ ! -d "$CLASSIC_DIR/.git" ]; then
  git clone --depth 1 https://github.com/OpenCut-app/opencut-classic.git "$CLASSIC_DIR" \
    || echo "WARNING: OpenCut classic clone failed" >&2
fi
# The rewrite has no root package.json; each app under apps/ installs its own deps.
if [ -d "$OPENCUT_DIR" ]; then
  (
    cd "$OPENCUT_DIR"
    export PATH="$HOME/.proto/bin:$PATH"
    proto use || echo "WARNING: proto use failed" >&2
    bun install --cwd apps/web || echo "WARNING: OpenCut web deps failed" >&2
    bun install --cwd apps/api || echo "WARNING: OpenCut api deps failed" >&2
  ) || true
fi
# Classic needs local Postgres + Redis and a Next.js dev server.
if [ -d "$CLASSIC_DIR" ]; then
  (
    cd "$CLASSIC_DIR"
    [ -f apps/web/.env.local ] || cp apps/web/.env.example apps/web/.env.local
    bun install || echo "WARNING: OpenCut classic deps failed" >&2
    docker compose up -d db redis serverless-redis-http \
      || echo "WARNING: OpenCut classic services failed" >&2
  ) || true
fi

echo "==> Done. Verify with: ffmpeg -version | head -1; yt-dlp --version; opencode --version; gh --version; ./facefusion/venv/bin/python ./facefusion/facefusion.py --version; ./ComfyUI/venv/bin/python ./ComfyUI/main.py --help"
echo "==> OpenCut start commands: classic: cd OpenCut-classic && bun dev:web (http://localhost:3000); rewrite: cd OpenCut/apps/web && bun run dev (http://localhost:5173); rewrite API: cd OpenCut/apps/api && bun run dev (http://localhost:8787)"
