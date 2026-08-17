#!/usr/bin/env bash
# Installs/updates Neovim to the latest stable release on macOS by
# downloading the official binary from GitHub (Homebrew's version lags
# far behind upstream), then clones or updates this config repo at
# ~/.config/nvim.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

NVIM_PREFIX="/opt/nvim"

install_neovim() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required. Install it from https://brew.sh and re-run this script." >&2
    exit 1
  fi

  echo "Installing dependencies..."
  brew install git make ripgrep curl

  local arch asset
  arch="$(uname -m)"
  case "$arch" in
    x86_64) asset="nvim-macos-x86_64.tar.gz" ;;
    arm64) asset="nvim-macos-arm64.tar.gz" ;;
    *)
      echo "Unsupported architecture: $arch" >&2
      exit 1
      ;;
  esac

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  echo "Downloading latest stable Neovim ($asset) from GitHub..."
  curl -fLo "$tmp_dir/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/download/stable/$asset"

  echo "Installing to $NVIM_PREFIX..."
  sudo rm -rf "$NVIM_PREFIX"
  sudo mkdir -p "$NVIM_PREFIX"
  sudo tar -xzf "$tmp_dir/nvim.tar.gz" -C "$NVIM_PREFIX" --strip-components=1
  # Downloaded binaries can be quarantined by Gatekeeper; clear it so
  # macOS doesn't block execution.
  sudo xattr -dr com.apple.quarantine "$NVIM_PREFIX" 2>/dev/null || true

  local link_dir="/usr/local/bin"
  sudo mkdir -p "$link_dir"
  sudo ln -sf "$NVIM_PREFIX/bin/nvim" "$link_dir/nvim"
}

install_neovim
install_config_repo

echo "Done. nvim version: $(nvim --version | head -n1)"
