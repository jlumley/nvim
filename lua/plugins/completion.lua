local use_copilot = (vim.env.COPILOT == 'true')

return {
  -- Completion UI
  {
    'Saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'nvim-lua/plenary.nvim',
      use_copilot and 'fang2hou/blink-copilot' or nil,
    },
    event = 'InsertEnter',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      local snippets_dir = vim.fn.getcwd() .. '/snippets'
      if vim.fn.isdirectory(snippets_dir) == 1 then
        require('luasnip.loaders.from_lua').lazy_load { paths = { snippets_dir } }
        vim.notify('Loaded project snippets', vim.log.levels.INFO)
      end

      local sources = { 'snippets', 'lsp', 'path', 'buffer' }
      local providers = {}
      if use_copilot then
        table.insert(sources, 2, 'copilot')
        providers.copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          score_offset = 100,
          async = true,
        }
      end

      require('blink.cmp').setup {
        snippets = {
          preset = 'luasnip',
        },
        keymap = {
          preset = 'default',
        },
        sources = {
          default = sources,
          providers = providers,
        },
        completion = {
          trigger = { prefetch_on_insert = true },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
        },
      }
    end,
  },
}
