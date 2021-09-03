local utils = require("utils")

utils.map('n', '<leader>.', '<cmd>RnvimrToggle<CR>')

vim.g.rnvimr_enable_ex = 0
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_enable_bw = 1
