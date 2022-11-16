local utils = require("utils")
local tsconf = require("nvim-treesitter.configs")

require("orgmode").setup_ts_grammar()
require("nvim-ts-autotag").setup()

if not tsconf then
	vim.cmd([[ echom 'Cannot load `nvim-treesitter.configs`' ]])
	return
end

tsconf.setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
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
