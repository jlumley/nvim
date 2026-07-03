-- ============================================================================
-- Neovim Configuration Overview
-- ============================================================================

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- [[ Options ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.o.tabstop = 4

-- Enable 24-bit (true) colors. Required for everforest and treesitter's
-- @* capture groups, which define GUI colors only -- without this most
-- highlighting renders with no color.
vim.opt.termguicolors = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Keymaps ]]
require 'keymaps'

-- [[ Autocommands ]]
require 'autocmds'

-- [[ lazy.nvim bootstrap ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

local imports = { { import = 'plugins' } }
local ai_plugins_env = os.getenv 'VIM_AI_PLUGINS'
if ai_plugins_env == 'true' then
  table.insert(imports, 2, { import = 'ai-plugins' })
end
require('lazy').setup(imports, {
  ui = {
    icons = {},
  },
  rocks = {
    enabled = true,
    hererocks = true,
  },
})
