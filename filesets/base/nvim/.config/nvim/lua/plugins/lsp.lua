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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim-ufo
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

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
	require("aerial").on_attach(client, bufnr)

	-- Normal mappings
	wk.register({
		c = {
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
			r = lsp_rename_mapping,
			f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format file" },
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
			a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range code action" },
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

	if client.name ~= "null-ls" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
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

require("nvim-lightbulb").setup({
	autocmd = {
		enabled = true,
	},
	sign = {
		enabled = false,
	},
	virtual_text = {
		enabled = true,
	},
})

require("fidget").setup({})
