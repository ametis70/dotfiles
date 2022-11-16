local wk = require("which-key")

require("mason-lspconfig").setup({
  automatic_installation = true,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

require("aerial").setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_rename_mapping = {
  function()
    vim.lsp.buf.rename()
  end,
  "Rename LSP symbol",
}
local lsp_references_mapping = {
  "<cmd>TroubleToggle lsp_references<CR>",
  "LSP references",
}

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Normal mappings
  wk.register({
    c = {
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
      r = lsp_rename_mapping,
      f = {
        "<cmd>lua vim.lsp.buf.format()<CR>",
        "Format file",
      },
      o = { "<cmd>AerialToggle!<CR>", "Toggle outline" },
      x = { "<cmd>lua vim.diagnostic.open_float({source= true})<CR>", "Show line diagnostics" },
      R = lsp_references_mapping,
      t = {
        name = "Trouble",
        t = { "<cmd>TroubleToggle<CR>", "Trouble Toggle" },
        r = lsp_references_mapping,
        w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", "Workspace diagnostics" },
        d = { "<cmd>TroubleToggle lsp_document_diagnostics<CR>", "Document diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<CR>", "Quickfix" },
        l = { "<cmd>TroubleToggle loclist<CR>", "Location list" },
      },
      g = {
        name = "Go to",
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
      },
    },
  }, {
    prefix = "<leader>",
    buffer = bufnr,
  })

  -- Visual mappings
  wk.register({
    c = {
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Range code action" },
      f = {
        "<cmd>lua vim.lsp.buf.format()<CR>",
        "Range formatting",
      },
    },
  }, {
    mode = "v",
    prefix = "<leader>",
    buffer = bufnr,
  })

  -- No leader mappings
  wk.register({
    gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover" },
    ["<C-k"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "LSP Signature" },
    ["<f2>"] = lsp_rename_mapping,
    ["[["] = { "<cmd>AerialPrevUp<CR>", "Outline previous" },
    ["]]"] = { "<cmd>AerialNext<CR>", "Outline next" },
  }, {
    buffer = bufnr,
  })

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if vim.g.format_on_save == 1 then
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      end,
    })
  end
end

local settings = {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Neovim
require("neodev").setup({})

local servers = {
  "clangd",
  "pyright",
  "rust_analyzer",
  "gopls",
  "phpactor",
  "tailwindcss",
  "jsonls",
  "sumneko_lua",
}

for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup(settings)
end

-- JSON
require("lspconfig").jsonls.setup(vim.tbl_deep_extend("force", settings, {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = {
        enable = true,
      },
    },
  },
}))

-- Typescript
require("typescript").setup({
  disable_commands = false,
  debug = false,
  server = settings,
})

-- null-ls
local null_ls = require("null-ls")

vim.g.format_on_save = 1

function _G.toggle_format_on_save()
  if vim.g.format_on_save == 1 then
    vim.g.format_on_save = 0
    print("Disabled format on save")
  else
    vim.g.format_on_save = 1
    print("Enabled format on save")
  end
end

require("null-ls").setup({
  sources = {
    -- General
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,

    -- Git
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.gitsigns,

    -- GitHub
    null_ls.builtins.diagnostics.actionlint,

    -- Shell
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,

    -- C/C++
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.cmake_format,

    -- Web
    null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.formatting.rustywind,

    -- Markdown
    null_ls.builtins.formatting.remark,

    -- Lua
    -- null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.stylua,

    -- Python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,

    -- PHP
    null_ls.builtins.diagnostics.phpstan,

    -- Go
    null_ls.builtins.formatting.gofmt,

    -- Rust
    null_ls.builtins.formatting.rustfmt,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})

require("nvim-lightbulb").setup({
  autocmd = {
    enabled = false,
  },
  sign = {
    enabled = false,
  },
  virtual_text = {
    enabled = false,
  },
})

require("fidget").setup({})
