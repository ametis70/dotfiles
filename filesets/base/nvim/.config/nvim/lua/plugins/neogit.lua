local neogit = require('neogit')
neogit.setup()

local wk = require('which-key')
wk.register({
    g = {
        g = {"<cmd>Neogit<CR>", "Neogit status"}
    }
}, {
    prefix = "<leader>"
})
