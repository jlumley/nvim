return {
  'OXY2DEV/markview.nvim',
  lazy = true,
  ft = { 'codecompainion', 'markdown' },

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  keys = {
    { '<leader>x', '<cmd>Checkbox toggle<CR>', ft = 'markdown', mode = { 'n', 'v' }, desc = 'Toggle markdown checkbox' },
  },

  config = function()
    require('markview').setup()
    require('markview.extras.checkboxes').setup()
  end,
}
