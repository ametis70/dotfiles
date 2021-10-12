local utils = require('utils')
utils.map('n', '<leader>op', '<cmd>NvimTreeToggle<CR>')

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1
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
    }
}

require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    update_to_buf_dir = {
        enable = true,
        auto_open = true
    },
    auto_close = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {}
    },
    system_open = {
        cmd = nil,
        args = {}
    },
    view = {
        width = 30,
        height = 30,
        side = 'left',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {}
        }
    }
}

vim.api.nvim_exec([[
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
    ]], false)
