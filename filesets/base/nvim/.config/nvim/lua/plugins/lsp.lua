local lsp = require("lspconfig")
local aerial = require("aerial")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {signs = true, virtual_text = true, underline = true})

local noremap = function(lhs, rhs, mode)
    mode = mode or 'n'
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

local set_lsp_config = function(client, bufnr)
    print("LSP started");
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    aerial.on_attach(client)

    local mappings = {
        v = {['<leader>ca'] = '<cmd><C-U>Lspsaga range_code_action<CR'},
        n = {
            ['gD'] = '<cmd>lua vim.lsp.buf.declaration()<CR>',
            ['gd'] = '<cmd>lua vim.lsp.buf.definition()<CR>',
            ['gi'] = '<cmd>lua vim.lsp.buf.implementation()<CR>',
            ['<silent>gh'] = '<cmd>Lspsaga lsp_finder',
            ['gh'] = '<cmd>Lspsaga lsp_finder<CR>',
            ['<leader>ca'] = '<cmd>Lspsaga code_action<CR>',
            ['K'] = '<cmd>Lspsaga hover_doc<CR>',
            ['gs'] = '<cmd>Lspsaga signature_help<CR>',
            ['gr'] = '<cmd>Lspsaga rename<CR>',
            ['<leader>cd'] = '<cmd>Lspsaga preview_definition<CR>',
            ['<leader>cX'] = '<cmd>Lspsaga show_line_diagnostics<CR>',
            ['[e'] = '<cmd>Lspsaga diagnostic_jump_next<CR>',
            [']e'] = '<cmd>Lspsaga diagnostic_jump_prev<CR>',
            ['<leader>co'] = '<cmd>AerialToggle!<CR>',
            ['[['] = '<cmd>AerialPrevUp<CR>',
            [']]'] = '<cmd>AerialNext<CR>'
        }
    }

    for mapping_type, map_table in pairs(mappings) do
        for lhs, rhs in pairs(map_table) do
            noremap(lhs, rhs, mapping_type)
        end
    end
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "tailwindcss" then
        opts.handlers = {
            ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr,
                                                        _)
                vim.lsp.buf_notify(bufnr,
                                   "tailwindcss/getConfigurationResponse",
                                   {_id = params._id})
            end
        }
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Lua
require('nlua.lsp.nvim').setup(lsp, {on_attach = set_lsp_config})

-- C/C++
lsp.clangd.setup {on_attach = set_lsp_config}

-- Golang
lsp.gopls.setup {on_attach = set_lsp_config}

-- PHP
lsp.phpactor.setup {on_attach = set_lsp_config}

-- Typescript
lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        set_lsp_config(client, bufnr)
    end
}

-- Python
lsp.pyright.setup {on_attach = set_lsp_config}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local flake8 = {
    lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local isort = {formatCommand = "isort --profile black -", formatStdin = true}

local phpstan = {
    lintCommand = "./vendor/bin/phpstan analyze --error-format raw --no-progress"
}

lsp.efm.setup {
    init_options = {
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
        documentFormatting = true
    },
    filetypes = {
        "javascript", "typescript", "javascriptreact", "typescriptreact",
        "python", "php", "blade"
    },
    on_attach = function(client, bufnr) set_lsp_config(client, bufnr) end,
    root_dir = function() return vim.fn.getcwd() end,
    settings = {
        rootMarkers = {".eslintrc", ".eslintrc.js", ".git/", "pyproject.toml"},
        languages = {
            javascript = {eslint},
            javascriptreact = {eslint},
            typescript = {eslint},
            typescriptreact = {eslint},
            python = {flake8, isort},
            php = {phpstan},
            blade = {phpstan}
        }
    }
}
