local utils = require("utils")
local tsconf = require("nvim-treesitter.configs")

require("nvim-ts-autotag").setup()

if not tsconf then
	vim.cmd([[ echom 'Cannot load `nvim-treesitter.configs`' ]])
	return
end

-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldenable = true
-- vim.o.foldmethod = "expr"
-- vim.o.foldcolumn = "1"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99

tsconf.setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	context_commentstring = {
		enable = true,
	},
})
