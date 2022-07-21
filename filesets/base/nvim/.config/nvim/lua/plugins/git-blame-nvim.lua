vim.g.gitblame_enabled = 0

local wk = require('which-key')

local wk_toggle_git_blame = {"<cmd>GitBlameToggle<CR>", "Toggle git blame"}

wk.register({
    t = {
        b = wk_toggle_git_blame
    },
    g = {
        b = wk_toggle_git_blame
    }
}, {
    prefix = "<leader>"
})
