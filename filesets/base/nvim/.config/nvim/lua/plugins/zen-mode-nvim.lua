require("zen-mode").setup()

local wk = require('which-key')

wk.register({
    t = {
        z = {"<cmd>ZenMode<CR>", "Zen mode"}
    }
}, {
    prefix = "<leader>"
})
