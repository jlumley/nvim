#!/usr/bin/env bash
# Shared helpers for the install scripts in this directory.
# Not meant to be run directly - sourced by install-debian.sh / install-macos.sh.

CONFIG_REPO_URL="https://github.com/jlumley/nvim.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

confirm() {
  local prompt="$1"
  local reply
  read -r -p "$prompt [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

install_config_repo() {
  if [[ -d "$CONFIG_DIR/.git" ]]; then
    if confirm "Config already exists at $CONFIG_DIR. Pull latest changes?"; then
      git -C "$CONFIG_DIR" pull --ff-only
    else
      echo "Skipping config update."
    fi
  elif [[ -e "$CONFIG_DIR" ]]; then
    if confirm "$CONFIG_DIR exists but is not the config repo. Overwrite it?"; then
      rm -rf "$CONFIG_DIR"
      git clone "$CONFIG_REPO_URL" "$CONFIG_DIR"
    else
      echo "Skipping config install."
    fi
  else
    mkdir -p "$(dirname "$CONFIG_DIR")"
    git clone "$CONFIG_REPO_URL" "$CONFIG_DIR"
  fi
}
