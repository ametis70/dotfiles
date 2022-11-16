local wk = require("which-key")

require("orgmode").setup({
	org_agenda_files = {
		"~/.org/work/*",
		"~/org/learning/*",
		"~/.org/projects/*",
		"~/.org/calendars/*",
		"~/.org/conferences/*",
	},
	org_default_notes_file = "~/.org/refile.org",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.org",
	callback = function()
		vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		vim.wo.foldmethod = "expr"
	end,
})

local wk_open_org_agenda = {
	[[<cmd>lua require('orgmode').action("agenda.prompt")<CR>]],
	"Org agenda",
}

wk.register({
	O = {
		name = "Org mode",
		a = wk_open_org_agenda,
		f = {
			[[<cmd>lua require('telescope.builtin').find_files{ cwd = '~/.org' }<CR>]],
			"Find file in notes",
		},
		n = {
			[[<cmd>lua require('orgmode').action("capture.prompt")<CR>]],
			"Org capture",
		},
		s = {
			[[<cmd>lua require('telescope.builtin').live_grep{ cwd = '~/.org' }<CR>]],
			"Search notes",
		},
	},
}, {
	prefix = "<leader>",
})
