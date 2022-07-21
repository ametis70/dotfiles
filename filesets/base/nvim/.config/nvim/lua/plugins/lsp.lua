require("nvim-lsp-installer").setup({
	automatic_installation = true,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

local aerial = require("aerial")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim-ufo
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	aerial.on_attach(client)

	local mappings = {
		["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
		["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
		["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
		["gi"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
		["<C-k"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
		["<leader>wa"] = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
		["<leader>wr"] = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
		["<leader>wl"] = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		["<leader>ca"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
		["gr"] = "<cmd>vim.lsp.buf.rename()<CR>",
		["<leader>cD"] = "<cmd>lua vim.lsp.buf.type_definition()<CR>",
		["<leader>cR"] = "<cmd>lua vim.lsp.buf.references()<CR>",
		["<leader>cf"] = "<cmd>lua vim.lsp.buf.formatting()<CR>",
		["<leader>co"] = "<cmd>AerialToggle!<CR>",
		["[["] = "<cmd>AerialPrevUp<CR>",
		["]]"] = "<cmd>AerialNext<CR>",
	}

	for lhs, rhs in pairs(mappings) do
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, {
			noremap = true,
			silent = true,
		})
	end

	-- Disable lsp formatting
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

local settings = {
	capabilities = capabilities,
	on_attach = on_attach,
}

local servers = {
	"clangd",
	"pyright",
	"rust_analyzer",
	"gopls",
	"phpactor",
	"tailwindcss",
	"jsonls",
}

for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup(settings)
end

-- Lua
require("lspconfig").sumneko_lua.setup(vim.tbl_deep_extend("force", require("lua-dev").setup(), settings))

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

function _G.toggle_format_on_save_global()
	if vim.g.format_on_save == 1 then
		vim.g.format_on_save = 0
	else
		vim.g.format_on_save = 1
	end

	print(vim.g.format_on_save)
end

function _G.toggle_format_on_save_buffer()
	if vim.b.format_on_save == 1 then
		vim.b.format_on_save = 0
	else
		vim.b.format_on_save = 1
	end

	print(vim.g.format_on_save)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					if vim.b.format_on_save ~= 0 and vim.g.format_on_save == 1 then
						vim.lsp.buf.formatting_sync()
					end
				end,
			})
		end
	end,
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
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.rustywind,

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

-- -- Typescript
-- lsp.tsserver.setup {
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         set_lsp_config(client, bufnr)
--     end
-- }
--
