local wk = require("which-key")

wk.register({
    f = {
        r = {"<cmd>RnvimrToggle<CR>", "Toggle Ranger"}
    }
}, {
    prefix = "<leader>"
})

vim.g.rnvimr_enable_ex = 0
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_enable_bw = 0
