local utils = require('utils')
local tsconf = require'nvim-treesitter.configs'

if not tsconf then
  vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
  return
end

utils.opt('w', 'foldmethod', 'expr')
utils.opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')

tsconf.setup {
  ensure_installed = "maintained", 
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }
}
