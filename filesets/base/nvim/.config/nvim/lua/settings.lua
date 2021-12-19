local utils = require('utils')

local cmd = vim.cmd
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', false)
utils.opt('b', 'autoindent', true)
utils.opt('b', 'softtabstop', indent)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'hidden', true)
utils.opt('w', 'wrap', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 10)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'foldlevel', 99)
utils.opt('w', 'cursorline', true)
utils.opt('o', 'clipboard', 'unnamed,unnamedplus')
utils.opt('o', 'lazyredraw', true)
utils.opt('b', 'undofile', true)

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

require('keybindings')
require('colorscheme')
