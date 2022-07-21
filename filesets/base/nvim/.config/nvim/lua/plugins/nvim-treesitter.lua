local utils = require('utils')
local tsconf = require 'nvim-treesitter.configs'

if not tsconf then
    vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
    return
end

vim.wo.foldenable = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99

tsconf.setup {
    ensure_installed = "all",
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    context_commentstring = {
        enable = true
    }
}
