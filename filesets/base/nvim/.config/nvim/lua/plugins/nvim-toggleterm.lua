local utils = require('utils')

require("toggleterm").setup{
    open_mapping = [[<a-`>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    direction = 'float',
    close_on_exit = false,
    float_opts = {
        winblend = 0,
        border = 'single',
    }
}

function _G.set_terminal_keymaps()
    utils.map('t', '<esc>', [[<C-\><C-n>]])
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
