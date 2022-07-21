require("twilight").setup()

local wk = require('which-key')

wk.register({
    t = {
        t = {"<cmd>Twilight<CR>", "Twilight"}
    }
}, {
    prefix = "<leader>"
})
