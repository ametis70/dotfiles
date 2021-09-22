local utils = require('utils')
local opts = { noremap = true, silent =  true }

utils.map('n', '<leader>gg', '<cmd>LazyGit<CR>', opts)
utils.map('n', '<leader>gc', '<cmd>LazyGitConfig<CR>', opts)

vim.env.GIT_EDITOR = 'nvr --remote-wait'
vim.g.lazygit_floating_window_use_plenary = 1
vim.g.lazygit_use_neovim_remote = 1
