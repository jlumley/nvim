#!/usr/bin/env bash
# Installs/updates Neovim to the latest stable release on Debian-based
# distros, then clones or updates this config repo at ~/.config/nvim.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

NVIM_PREFIX="/opt/nvim"

install_neovim() {
  local arch
  arch="$(uname -m)"
  case "$arch" in
    x86_64) asset="nvim-linux-x86_64.tar.gz" ;;
    aarch64 | arm64) asset="nvim-linux-arm64.tar.gz" ;;
    *)
      echo "Unsupported architecture: $arch" >&2
      exit 1
      ;;
  esac

  echo "Installing dependencies..."
  sudo apt-get update
  sudo apt-get install -y curl tar git make unzip gcc ripgrep

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  echo "Downloading latest stable Neovim ($asset)..."
  curl -fLo "$tmp_dir/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/download/stable/$asset"

  echo "Installing to $NVIM_PREFIX..."
  sudo rm -rf "$NVIM_PREFIX"
  sudo mkdir -p "$NVIM_PREFIX"
  sudo tar -xzf "$tmp_dir/nvim.tar.gz" -C "$NVIM_PREFIX" --strip-components=1

  sudo ln -sf "$NVIM_PREFIX/bin/nvim" /usr/local/bin/nvim
}

install_neovim
install_config_repo

echo "Done. nvim version: $(nvim --version | head -n1)"
