require("zk").setup()
require("mkdnflow").setup({})
require("telescope").load_extension("zk")

local wk = require("which-key")

wk.register({
	n = {
		n = {
			function()
				vim.ui.input({ prompt = "Note title: " }, function(input)
					require("zk.commands").get("ZkNew")({ title = input })
				end)
			end,
			"Create new note",
		},
		d = {
			function()
				require("zk.commands").get("ZkNew")({ dir = "journal" })
			end,
			"Create or edit daily note",
		},
		f = {
			function()
				require("zk.commands").get("ZkNotes")()
			end,
			"Find note",
		},
		i = {
			function()
				require("zk.commands").get("ZkIndex")()
			end,
			"Index notes",
		},
		t = {
			function()
				require("zk.commands").get("ZkTag")()
			end,
			"Search by tag",
		},
	},
}, {
	prefix = "<leader>",
})

local augroup = vim.api.nvim_create_augroup("MarkdownZk", {})
local ZK_NOTEBOOK_DIR = vim.env.ZK_NOTEBOOK_DIR
local patt = { ZK_NOTEBOOK_DIR .. "/*.md" }

vim.api.nvim_clear_autocmds({ group = augroup })
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	pattern = patt,
	callback = function(bufnr)
		vim.cmd("lcd %:p:h")

		wk.register({
			t = {
				function()
					require("zk.commands").get("ZkNewFromTitleSelection")()
				end,
				"New note (selected as title)",
			},
			c = {
				function()
					require("zk.commands").get("ZkNewFromContentSelection")()
				end,
				"New note (selected as content)",
			},
			m = {
				function()
					require("zk.commands").get("ZkMatch")()
				end,
				"Find note match",
			},
		}, {
			mode = "v",
			bufnr = bufnr,
			prefix = "<localleader>",
		})

		wk.register({
			b = {
				function()
					require("zk.commands").get("ZkBacklinks")()
				end,
				"Show note backlinks",
			},
			l = {
				function()
					require("zk.commands").get("ZkLinks")()
				end,
				"Show note links",
			},
		}, {
			mode = "n",
			bufnr = bufnr,
			prefix = "<localleader>",
		})
	end,
})
