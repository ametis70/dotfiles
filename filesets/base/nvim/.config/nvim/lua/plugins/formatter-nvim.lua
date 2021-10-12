local prettier = function()
    return {
        exe = "prettier",
        args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote',
            '--no-semi'
        },
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

local clang_format = function()
    return {
        exe = "clang-format",
        args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
        stdin = true,
        cwd = vim.fn.expand('%:p:h')
    }
end

local gofmt = function()
    return {
        exe = "gofmt",
        stdin = true
    }
end

local blade_formatter = function()
    return {
        exe = "blade-formatter",
        args = {"--stdin"},
        stdin = true
    }
end

local lua_formatter = function()
    return {
        exe = "lua-format",
        stdin = true
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        c = {clang_format},
        blade = {blade_formatter},
        go = {gofmt},
        cpp = {clang_format},
        javascript = {prettier},
        javascriptreact = {prettier},
        typescript = {prettier},
        typescriptreact = {prettier},
        php = {prettier},
        css = {prettier},
        html = {prettier},
        python = {black},
        lua = {lua_formatter}
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.c,*.h,*.cpp,*.go,*.html,*.css,*.js,*.ts,*.jsx,*.tsx,*.py,*.blade.php,*.php,*.lua FormatWrite
augroup END
]], true)
