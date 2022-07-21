vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {
    'help', 'dashboard', 'dashpreview', 'coc-explorer', 'startify', 'vista',
    'sagahover', 'lspinfo'
}

local wk = require('which-key')

wk.register({
    t = {
        i = {"<cmd>IndentBlanklineToggle<CR>", "Indent guides"}
    }
}, {
    prefix = "<leader>"
})
