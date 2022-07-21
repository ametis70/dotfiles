local wk = require('which-key')

wk.setup()

wk.register({
    f = {
        name = 'File',
        C = {
            function()
                vim.api.nvim_input(':Copy ' .. vim.fn.expand('%'))
            end, "Copy file"
        },
        R = {
            function()
                vim.api.nvim_input(':Move ' .. vim.fn.expand('%'))
            end, "Rename/move file"
        },
        D = {function() vim.api.nvim_input(':Delete') end, "Delete file"}
    },
    b = {
        name = "Buffer",
        k = {"<cmd>bdel<CR>", "Kill buffer"},
        s = {"<cmd>write<CR>", "Save buffer"}
    },
    h = {
        name = "Help"
    },
    p = {
        name = "Project"
    },
    n = {
        name = "Note"
    },
    t = {
        name = "Toggle"
    },
    g = {
        name = "Git"
    }
}, {
    prefix = "<leader>"
})
