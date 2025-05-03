#!/bin/bash

set -euo pipefail

declare -r WORKDIR="$1"
declare -r BUILDDIR="$WORKDIR/build"
declare -r OUTPUTDIR="$WORKDIR/output"
declare -r CLONEDIR="$WORKDIR/clone"
declare -r VENVDIR="$WORKDIR/venv"
declare -r IMAGE_VERSION="$2"

fakechroot -- fakeroot -- chroot "$BUILDDIR" test "$(wc -l /etc/group | awk '{print $1}')" -gt 10
fakechroot -- fakeroot -- chroot "$BUILDDIR" test "$(wc -l /etc/passwd | awk '{print $1}')" -gt 10
fakechroot -- fakeroot -- chroot "$BUILDDIR" pacman -Sy
fakechroot -- fakeroot -- chroot "$BUILDDIR" pacman -Qqk
fakechroot -- fakeroot -- chroot "$BUILDDIR" pacman -Syu --noconfirm podman grep
fakechroot -- fakeroot -- chroot "$BUILDDIR" podman -v
fakechroot -- fakeroot -- chroot "$BUILDDIR" id -u http
fakechroot -- fakeroot -- chroot "$BUILDDIR" locale | grep -q UTF-8

if [ -d "$CLONEDIR" ]; then
	git -C "$CLONEDIR" pull https://github.com/microsoft/WSL.git 
else
	git clone https://github.com/microsoft/WSL.git "$CLONEDIR"
fi
python -m venv "$VENVDIR"
export PATH="$VENVDIR/bin:$PATH"
pip install -r "$CLONEDIR/distributions/requirements.txt"
python "$CLONEDIR/distributions/validate-modern.py" --tar "$OUTPUTDIR/parchlinux-$IMAGE_VERSION.wsl"
