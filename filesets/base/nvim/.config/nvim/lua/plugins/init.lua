---@diagnostic disable: undefined-global
return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("antoinemadec/FixCursorHold.nvim")

	-- Project management
	use({
		"ahmedkhalf/project.nvim",
		config = [[require('plugins.project-nvim')]],
	})

	-- GUI
	use("stevearc/dressing.nvim")

	-- Fuzzy finder
	use({
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = [[require('plugins.telescope-nvim')]],
		},
	})

	-- File explorer
	use({
		"kevinhwang91/rnvimr",
		config = [[require('plugins.rnvimr')]],
	})

	use({
		"kyazdani42/nvim-tree.lua",
		config = [[require('plugins.nvim-tree')]],
	})

	-- Refactor
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = [[ require('refactoring').setup({}) ]],
	})

	-- Tooling
	use({
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"williamboman/mason.nvim",
			config = [[ require('plugins.tooling') ]],
		},
	})

	-- LSP
	use({
		"folke/lsp-colors.nvim", -- Color groups
		{
			-- Installer
			"williamboman/mason-lspconfig.nvim",
			require = "williamboman/mason.nvim",
		},
		"folke/lua-dev.nvim", -- Lua
		"jose-elias-alvarez/typescript.nvim", -- Typsecript
		"jose-elias-alvarez/null-ls.nvim", -- Tooling
		"stevearc/aerial.nvim", -- Outline
		"b0o/schemastore.nvim", -- JSON schemas
		"folke/trouble.nvim", -- Diagnostics
		"kosayoda/nvim-lightbulb", -- Lightbulb
		"j-hui/fidget.nvim", -- LSP Status indicator
		{
			"neovim/nvim-lspconfig", -- Config
			config = [[require('plugins.lsp')]],
		},
	})

	-- Buffer line
	-- use {
	--     'akinsho/bufferline.nvim',
	--     tag = "v2.*",
	--     requires = 'kyazdani42/nvim-web-devicons',
	--     config = function() require("bufferline").setup {} end
	-- }

	-- Completion
	use({
		"onsails/lspkind-nvim", -- Pretty icons
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-omni",
		"petertriho/cmp-git",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			"hrsh7th/nvim-cmp",
			config = [[require('plugins.nvim-cmp')]],
		},
	})

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	-- Tree-sitter
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag", -- XML-like auto tags
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = [[require('plugins.nvim-treesitter')]],
		},
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "v2.*",
		config = [[require('plugins.nvim-toggleterm')]],
	})

	-- Git
	use({
		{
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
		},
		"tpope/vim-fugitive",
		"TimUntersberger/neogit",
		"f-person/git-blame.nvim",
		{
			"sindrets/diffview.nvim",
			requires = "nvim-lua/plenary.nvim",
		},
		{
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = [[require('plugins.git')]],
		},
	})

	-- Indent lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = [[require('plugins.indent-blankline-nvim')]],
	})

	-- Handy stuff
	use({
		"ygm2/rooter.nvim",
		config = function()
			vim.g.outermost_root = false
		end,
	})
	use({ "dhruvasagar/vim-table-mode" })
	use({ "tpope/vim-eunuch" })

	use({
		"folke/which-key.nvim",
		config = [[require('plugins.which-key')]],
	})

	use({
		"folke/zen-mode.nvim",
		config = [[require('plugins.zen-mode-nvim')]],
	})

	use({
		"folke/twilight.nvim",
		config = [[require('plugins.twilight-nvim')]],
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	-- Statusline
	-- use {
	--     'ojroques/nvim-hardline',
	--     config = [[require('plugins.hardline')]]
	-- }

	use({
		"hoob3rt/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
		config = [[require('plugins.lualine')]],
	})

	-- Folding
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = [[require('plugins.nvim-ufo')]],
	})

	-- Color highlighting
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Colorschemes
	use({
		"Th3Whit3Wolf/onebuddy",
		requires = { "tjdevries/colorbuddy.vim" },
	})
	use({ "RRethy/nvim-base16" })
	use({ "NTBBloodbath/doom-one.nvim" })
	use({ "folke/tokyonight.nvim" })
	use({ "marko-cerovac/material.nvim" })

	use({
		"kyazdani42/nvim-web-devicons",
		config = [[require('plugins.nvim-web-devicons')]],
	})

	-- package.json
	use("vuki656/package-info.nvim")

	-- Blade
	use({ "Eduruiz/vim-blade" })

	-- org-mode
	use({
		"kristijanhusak/orgmode.nvim",
		config = [[require('plugins.orgmode-nvim')]],
	})

	-- DAP
	use("mfussenegger/nvim-dap")
	use("Pocco81/dap-buddy.nvim")
	use("rcarriga/nvim-dap-ui")

	-- Test runner
	use("David-Kunz/jester")
end)
