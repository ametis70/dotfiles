local wk = require('which-key')
wk.register({
    g = {
        f = {"<cmd>Git<CR>", "Fugitive status"}
    }
}, {
    prefix = "<leader>"
})
