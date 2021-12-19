require("toggleterm").setup {
    open_mapping = [[<a-`>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    direction = 'tab',
    close_on_exit = false,
    float_opts = {
        winblend = 0,
        border = 'single'
    }
}

function _G.set_terminal_keymaps()
    local opts = {
        noremap = true
    }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
