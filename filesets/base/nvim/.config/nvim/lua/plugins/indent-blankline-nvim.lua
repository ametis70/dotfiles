local utils = require('utils')

utils.map('n', '<leader>i', ':IndentBlanklineToggle<CR>', {noremap = true, silent = true})

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {'help','dashboard','dashpreview','coc-explorer','startify','vista','sagahover', 'lspinfo'}
