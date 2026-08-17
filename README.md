# nvim

My personal Neovim configuration, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Setup

Run the install script for your OS. Each one installs/updates Neovim to the
latest stable release, installs the required dependencies, and clones (or
updates) this config into `~/.config/nvim`.

**macOS** (requires [Homebrew](https://brew.sh)):

```sh
curl -fsSL https://raw.githubusercontent.com/jlumley/nvim/main/install/install-macos.sh | bash
```

**Debian/Ubuntu:**

```sh
curl -fsSL https://raw.githubusercontent.com/jlumley/nvim/main/install/install-debian.sh | bash
```

Or, if you already have this repo cloned:

```sh
./install/install-macos.sh    # or
./install/install-debian.sh
```

If a config already exists at `~/.config/nvim`, the script will prompt to
pull the latest changes (if it's this repo) or overwrite it.

## Requirements

- `git`, `make`, `unzip`, a C compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- A clipboard tool (xclip/xsel on Linux)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons - set `vim.g.have_nerd_font` in `init.lua`)

The install scripts handle these automatically.

## Usage

```sh
nvim
```

Plugins install automatically on first launch via [lazy.nvim](https://lazy.folke.io/).
Run `:Lazy` to check plugin status, `:checkhealth` to verify your setup.

See `init.lua` for the full configuration and inline documentation.
