# Server Environment Inventory

_Generated 2026-11-19 22:26:04 from the OpenCode cloud runner._

## Summary

| Category | Count |
|---|---:|
| apt packages (manual) | 245 |
| pip packages | 98 |
| npm global packages | 7 |
| pipx tools | 2 |
| OpenCode skills | 1 installed + 2 built-in (`opencode`, `report`) |

## Setup / restore

- `setup.sh` — installs every apt / pip / npm / pipx package listed above and restores the skills folder.
- `requirements.txt` — exact `pip freeze` output used by `setup.sh`.
- `skills/` — backup of `~/.config/opencode/skill` (the `opencode` and `report` skills ship with the CLI).
- `clips/`, `viral_final/`, `gta6_clips.zip` — large binaries (`*.mp4`, `*.zip`) are gitignored and remain local only; captions, SRT, JSON and text manifests are backed up.

## Key binaries

| Tool | Path | Version |
|---|---|---|
| `ffmpeg` | /usr/bin/ffmpeg | - |
| `ffprobe` | /usr/bin/ffprobe | - |
| `yt-dlp` | /home/runner/.local/bin/yt-dlp | 2026.10.26 |
| `node` | /usr/local/bin/node | v24.22.2 |
| `npm` | /usr/local/bin/npm | 11.19.1 |
| `git` | /usr/bin/git | git version 2.56.1 |
| `gh` | /usr/bin/gh | gh version 2.103.3 (2026-10-26) |
| `git-lfs` | /usr/bin/git-lfs | git-lfs/3.8.1 (GitHub; linux amd64; go 1.27.3) |
| `jq` | /usr/bin/jq | jq-1.8.1 |
| `curl` | /usr/bin/curl | curl 8.18.0 (x86_64-pc-linux-gnu) libcurl/8.18.0 OpenSSL/3.5.5 zlib/1.3.1 brotli |
| `python3` | /usr/bin/python3 | Python 3.14.4 |
| `pip3` | /usr/bin/pip3 | pip 25.1.1 from /usr/lib/python3/dist-packages/pip (python 3.14) |
| `uv` | /home/runner/.local/bin/uv | uv 0.13.9 (x86_64-unknown-linux-gnu) |

## Git repositories on this server

| Folder | Remote |
|---|---|
| `workspace` | https://github.com/Munna93s/opencode-server |
| `beyondgtaclips skill` | https://github.com/beyondtahir/beyondgtaclips.git |
| `openshorts` | https://github.com/mutonby/openshorts.git |
| `openclip` | https://github.com/linzzzzzz/openclip.git |
| `nvm` | https://github.com/nvm-sh/nvm.git |

## Local project folders (installed on this server)

- `~/openclip` — video clipping app (clone of `linzzzzzz/openclip`, ~7.2 GB incl. `.venv`).
- `~/openshorts` — short-form video app (clone of `mutonby/openshorts`, ~175 MB).
- `~/.config/opencode/skill/beyondgtaclips` — GTA 6 clipping skill (11 MB).
- `~/BeyondGTAClips`, `~/.beyondgtaclips` — skill runtime state, watchlists and ONNX models.
- `~/.nvm`, `~/.cargo`, `~/.rustup`, `~/.dotnet`, `~/.composer`, `~/.ghcup` — language version managers.
- `~/actions-runner` — GitHub Actions runner binaries (~164 MB).

> **Security note:** `~/openshorts/.env` contains real credentials. It is deliberately NOT copied
> into this workspace / repository. Reproduce it from `~/openshorts/.env.example` and your own secrets.

## apt packages (manual)

```text
7zip
7zip-rar
acl
ant
ant-optional
apache2
apt
apt-transport-https
aria2
autoconf
automake
azure-cli
azure-vm-utils
bash
bind9-dnsutils
binutils
bison
brotli
buildah
bzip2
ca-certificates
cifs-utils
clang-20
clang-21
clang-22
clang-format-20
clang-format-21
clang-format-22
clang-tidy-20
clang-tidy-21
clang-tidy-22
cloud-guest-utils
cloud-init
cloud-init-base
containerd.io
coreutils
curl
dash
dbus
diffutils
docker-ce
docker-ce-cli
dpkg
dpkg-dev
eatmydata
efibootmgr
fakeroot
fdisk
ffmpeg
file
findutils
firefox
flex
fonts-noto-color-emoji
ftp
g++
g++-13
g++-14
g++-15
gcc
gdisk
gfortran
gfortran-13
gfortran-14
gfortran-15
gh
git-ftp
git-lfs
gnupg
gnupg2
google-chrome-stable
google-cloud-cli
grep
grub-pc
gzip
hostname
init
iproute2
iputils-ping
jq
keyutils
kubectl
libc6
libcrypt-dev
libeatmydata1
libgcc-s1
libgmp-dev
libgssapi-krb5-2
libicu-dev
libicu78
libjitterentropy3-dev
libjs-sphinxdoc
liblttng-ust1t64
liblz4-dev
libmysqlclient-dev
libnss3-tools
libpq-dev
libsqlite3-dev
libssl-dev
libssl3t64
libstdc++6
libtool
libtss2-esys-3.0.2-0t64
libtss2-mu-4.0.1-0t64
libtss2-rc0t64
libwrap0
libxtst6
libyaml-dev
linux-azure
linux-base
lld-20
lld-21
lld-22
lldb-21
locales
lsb-release
lsscsi
lz4
m4
make
microsoft-edge-stable
mysql-client
mysql-server
ncurses-base
ncurses-bin
ncurses-term
net-tools
nftables
nginx
nvme-cli
openssh-client
openssh-server
openssh-sftp-server
openssl
packages-microsoft-prod
parallel
patchelf
php-pear
php8.5
php8.5-amqp
php8.5-apcu
php8.5-bcmath
php8.5-bz2
php8.5-cgi
php8.5-cli
php8.5-common
php8.5-curl
php8.5-dba
php8.5-dev
php8.5-enchant
php8.5-fpm
php8.5-gd
php8.5-gmp
php8.5-igbinary
php8.5-imagick
php8.5-interbase
php8.5-intl
php8.5-ldap
php8.5-mbstring
php8.5-memcache
php8.5-memcached
php8.5-mongodb
php8.5-mysql
php8.5-odbc
php8.5-pcov
php8.5-pgsql
php8.5-phpdbg
php8.5-pspell
php8.5-readline
php8.5-redis
php8.5-snmp
php8.5-soap
php8.5-sqlite3
php8.5-sybase
php8.5-tidy
php8.5-xdebug
php8.5-xml
php8.5-xsl
php8.5-yaml
php8.5-zip
php8.5-zmq
pigz
pkg-config
podman
pollinate
postgresql-18
python-babel-localedata
python-is-python3
python3
python3-babel
python3-dev
python3-jinja2
python3-json-pointer
python3-jsonpatch
python3-jsonschema
python3-jsonschema-specifications
python3-markupsafe
python3-passlib
python3-pip
python3-referencing
python3-rpds-py
python3-serial
python3-venv
rpm
rsync
ruby-full
session-manager-plugin
shellcheck
shim-signed
skopeo
snmp
software-properties-common
sqlite3
ssh
ssh-import-id
sshpass
sudo
swig
sysstat
systemd-coredump
tar
telnet
temurin-11-jdk
temurin-17-jdk
temurin-21-jdk
temurin-25-jdk
texinfo
time
tk
tree
tzdata
ubuntu-minimal
ubuntu-server
ubuntu-standard
unzip
upx-ucl
util-linux
walinuxagent
wget
xvfb
xz-utils
zip
zlib1g
zlib1g-dev
zsync
```

## pip packages

```text
argcomplete==3.7.2
attrs==25.4.0
autocommand==2.2.2
Automat==25.4.16
babel==2.17.0
bcc==0.35.0
bcrypt==5.0.0
blinker==1.9.0
boto3==1.40.72
botocore==1.40.72
certifi==2026.1.4
chardet==5.2.0
click==8.1.8
command-not-found==0.3
configobj==5.0.9
constantly==23.10.4
crit==4.2
cryptography==46.0.5
dbus-python==1.4.0
distro-info==1.15+ubuntu0.1
distro==1.9.0
filelock==4.2.10
httplib2==0.22.0
hyperlink==21.0.0
idna==3.11
incremental==24.7.2
inflect==7.5.0
jaraco.context==6.0.1
jaraco.functools==4.1.0
jaraco.text==4.0.0
Jinja2==3.1.6
jmespath==1.0.1
jsonpatch==1.32
jsonpointer==2.4
jsonschema-specifications==2023.12.1
jsonschema==4.19.2
launchpadlib==2.1.0
lazr.restfulclient==0.14.6
lazr.uri==1.0.6
libpass==1.9.3
linkify-it-py==2.0.3
markdown-it-py==3.0.0
MarkupSafe==3.0.3
mdurl==0.1.2
more-itertools==10.8.0
netaddr==1.3.0
netifaces==0.11.0
oauthlib==3.3.1
packaging==26.0
pexpect==4.9.0
pillow==13.0.0
pip==25.1.1
pipx==1.17.10
platformdirs==4.14.5
protobuf==4.21.12
ptyprocess==0.7.0
pyasn1==0.6.3
pyasn1_modules==0.4.1
pycriu==4.2
Pygments==2.19.2
PyGObject==3.56.2
PyHamcrest==2.1.0
PyJWT==2.10.1
pyOpenSSL==25.3.0
pyparsing==3.3.2
pyserial==3.5
python-apt==3.1.0+ubuntu1.1
python-dateutil==2.9.0
python-debian==1.0.1+ubuntu2
python-magic==0.4.27
PyYAML==6.0.3
referencing==0.36.2
requests==2.32.5
rich==13.9.4
rpds-py==0.27.1
s3transfer==0.14.0
service-identity==24.2.0
setuptools==78.1.1
six==1.17.0
sos==4.11.2
ssh-import-id==5.11
systemd-python==235
Twisted==25.5.0
typeguard==4.4.4
typing_extensions==4.15.0
ubuntu-pro-client==8001
uc-micro-py==1.0.3
ufw==0.36.2
urllib3==2.6.3
userpath==1.9.2
uv==0.13.9
wadllib==2.0.0
WALinuxAgent==2.15.0.1
wheel==0.46.3
yt-dlp==2026.10.26
zipp==3.23.0
zope.interface==8.2
zstandard==0.25.0
```

## npm global packages

```text
@bazel/bazelisk@v1.28.1
@opencode/cli@2.3.2
cloudflared@0.7.3
corepack@0.36.0
n@11.0.0
npm@11.19.1
yarn@1.22.22
```

## pipx tools

```text
ansible-core==2.22.0
yamllint==1.38.0
```

