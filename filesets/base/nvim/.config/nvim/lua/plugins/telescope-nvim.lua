local wk = require("which-key")
local actions = require("telescope.actions")

local M = {}

M.project_files = function()
	local opts = {}
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.file_browser = function()
	require("telescope").extensions.file_browser.file_browser({
		cwd = vim.fn.expand("%:p:h"),
	})
end

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		git_files = {
			show_untracked = true,
		},
		find_files = {
			hidden = true,
			follow = true,
		},
		live_grep = {
			hidden = true,
			follow = true,
		},
	},
	extensions = {
		file_browser = {
			hidden = true,
			follow = true,
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")

local browse_files = {
	function()
		M.file_browser()
	end,
	"Browse files",
}
local find_file_in_project = {
	function()
		M.project_files()
	end,
	"Find file in project",
}

wk.register({
	f = {
		f = { "<cmd>Telescope find_files<cr>", "Find file" },
		p = {
			[[<cmd>lua require('telescope.builtin').find_files{ cwd = '~/.config/nvim/' }<CR>]],
			"Find config file",
		},
		o = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
		b = browse_files,
	},
	b = {
		b = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
	},
	h = {
		h = { "<cmd>Telescope help_tags<CR>", "Vim help tags" },
		m = { "<cmd>Telescope man_pages<CR>", "Man pages" },
	},
	p = {
		p = { "<cmd>Telescope projects<CR>", "Switch to project" },
		f = find_file_in_project,
	},
	g = {
		c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
		C = { "<cmd>Telescope git_bcommits<CR>", "Checkout buffer commit" },
		B = { "<cmd>Telescope git_branches<CR>", "Switch branch" },
		s = { "<cmd>Telescope git_stash<CR>", "Apply stash" },
	},
	["<space>"] = find_file_in_project,
	["."] = browse_files,
	[","] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
	["/"] = { "<cmd>Telescope live_grep<CR>", "Live grep" },
}, {
	prefix = "<leader>",
})

return M
