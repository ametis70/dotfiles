local get_buffer_name = function()
    -- Prevent glob expansion on weird filenames
    return "'" .. vim.api.nvim_buf_get_name(0) .. "'"
end

local prettier = function()
    return {
        exe = "prettier",
        args = {
            "--stdin-filepath", get_buffer_name(), '--single-quote',
            '--no-semi', '--prose-wrap', 'always'
        },
        stdin = true
    }
end

local black = function()
    return {
        exe = "black",
        args = {"-q", "--stdin-filename", get_buffer_name(), "-"},
        stdin = true
    }
end

local clang_format = function()
    return {
        exe = "clang-format",
        args = {"--assume-filename", get_buffer_name()},
        stdin = true,
        cwd = vim.fn.expand('%:p:h')
    }
end

local gofmt = function() return {exe = "gofmt", stdin = true} end

local blade_formatter = function()
    return {exe = "blade-formatter", args = {"--stdin"}, stdin = true}
end

local lua_formatter = function() return {exe = "lua-format", stdin = true} end

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
        yaml = {prettier},
        python = {black},
        lua = {lua_formatter}
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.c,*.h,*.cpp,*.go,*.html,*.css,*.js,*.ts,*.jsx,*.tsx,*.py,*.blade.php,*.php,*.lua,*.yaml,*.yml FormatWrite
augroup END
]], true)
