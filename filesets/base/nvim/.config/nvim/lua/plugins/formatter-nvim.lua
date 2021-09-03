local prettier = function()
    return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote', '--no-semi'},
        stdin = true
    }
end

local black = function()
    return {
        exe = "black",
        args = {"-q", "--stdin-filename", vim.api.nvim_buf_get_name(0), "-"},
        stdin = true
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = {prettier},
        javascriptreact = {prettier},
        typescript = {prettier},
        typescriptreact = {prettier},
        python = {black}
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx,*.py FormatWrite
augroup END
]], true)
