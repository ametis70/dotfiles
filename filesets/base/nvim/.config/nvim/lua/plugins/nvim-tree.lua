local utils = require('utils')
utils.map('n', '<leader>op', '<cmd>NvimTreeToggle<CR>')

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders =  1,
    files = 1,
    folder_arrows = 1,
}


vim.g.nvim_tree_icons = {
    default = '',
    git = {
      unstaged = '',
      staged = '',
      unmerged = '',
      renamed = '',
      untracked = '',
      deleted = '',
      ignored = ""
    },
}

vim.api.nvim_exec(
[[
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]],
false
)
