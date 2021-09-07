---@diagnostic disable: undefined-global

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {'ibhagwan/fzf-lua',
        requires = {
            'vijaymarupudi/nvim-fzf',
            'kyazdani42/nvim-web-devicons' -- optional for icons
        },
        config = [[require('plugins.fzf-lua')]]
    }

    use {
        'kevinhwang91/rnvimr',
        config = [[require('plugins.rnvimr')]]
    }

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        config = [[require('plugins.nvim-tree')]]
    }

    -- LSP config
    use {
        'neovim/nvim-lspconfig',
        config = [[require('plugins.lsp')]]
    }

    -- Langugage specific LSP plugins
    use { 'tjdevries/nlua.nvim' }

    -- Additional LSP plugins
    use {
        'glepnir/lspsaga.nvim',
        config = [[require('plugins.lspsaga-nvim')]]
    }

    use { 'folke/lsp-colors.nvim' }

    -- Outline (LSP)
    -- use { 'simrat39/symbols-outline.nvim' }
    use { 'stevearc/aerial.nvim' }

    -- Diagnostics
    use {
        'folke/trouble.nvim',
        config = [[require('plugins.trouble-nvim')]]
    }

    -- Tree-sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('plugins.nvim-treesitter')]]
    }

    -- Formatting
    use {
        'mhartington/formatter.nvim',
        config = [[require('plugins.formatter-nvim')]]
    }
    use {
        'davinche/whitespace-vim',
        config = [[require('plugins.whitespace-vim')]]
    }

    -- Completion
    use {
        'hrsh7th/nvim-compe',
        config = [[require('plugins.nvim-compe')]]
    }

    -- Snippets
    use { 'hrsh7th/vim-vsnip' }
    use { 'hrsh7th/vim-vsnip-integ' }

    -- Terminal
    use {
        "akinsho/nvim-toggleterm.lua",
        config = [[require('plugins.nvim-toggleterm')]]
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require('plugins.gitsigns-nvim')]]
    }
    use { 'tpope/vim-fugitive' }
    use {
        'kdheepak/lazygit.nvim',
        config = [[require('plugins.lazygit-nvim')]]
        }

    -- Indent lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = [[require('plugins.indent-blankline-nvim')]]
    }

    -- Handy stuff
    use { 'ygm2/rooter.nvim' }
    use { 'dhruvasagar/vim-table-mode' }
    use { 'tpope/vim-eunuch' }

    -- Statusline
    -- use {
    --     'ojroques/nvim-hardline',
    --     config = [[require('plugins.hardline')]]
    -- }

    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = [[require('plugins.lualine')]]
    }

    -- Syntax plugins
    use { 'euclidianAce/BetterLua.vim' }

    -- Color highlighting
    use { 'norcalli/nvim-colorizer.lua' }

    -- Colorschemes
    use {
        'Th3Whit3Wolf/onebuddy',
        requires = { {'tjdevries/colorbuddy.vim'} }
    }
    use { 'RRethy/nvim-base16' }
    use { 'NTBBloodbath/doom-one.nvim' }
    use { 'folke/tokyonight.nvim' }
    use { 'marko-cerovac/material.nvim' }

    -- Cursorline
    -- use { 'xiyaowong/nvim-cursorword' }
    -- use { 'yamatsum/nvim-cursorline' }

    use {
        'kyazdani42/nvim-web-devicons',
        config = [[require('plugins.nvim-web-devicons')]]
    }

    -- Python
    use {
        'petobens/poet-v',
        config = [[require('plugins.poet-v')]]
    }
end)

