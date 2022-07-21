---@diagnostic disable: undefined-global
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'antoinemadec/FixCursorHold.nvim'

    use {
        "ahmedkhalf/project.nvim",
        config = [[require('plugins.project-nvim')]]
    }

    use {
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }, "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim", {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/plenary.nvim'}},
            config = [[require('plugins.telescope-nvim')]]
        }
    }

    -- File explorer
    use {
        'kevinhwang91/rnvimr',
        config = [[require('plugins.rnvimr')]]
    }

    use {
        'kyazdani42/nvim-tree.lua',
        config = [[require('plugins.nvim-tree')]]
    }

    -- LSP
    use {
        'folke/lsp-colors.nvim', -- Color groups
        'williamboman/nvim-lsp-installer', -- Installer
        'folke/lua-dev.nvim', -- Lua
        'jose-elias-alvarez/typescript.nvim', -- Typsecript
        'jose-elias-alvarez/null-ls.nvim', -- Tooling
        'stevearc/aerial.nvim', -- Outline
        'b0o/schemastore.nvim', -- JSON schemas
        {
            -- Diagnostics
            'folke/trouble.nvim',
            config = [[require('plugins.trouble-nvim')]]
        }, {
            -- Lightbulb
            'kosayoda/nvim-lightbulb',
            config = function()
                require('nvim-lightbulb').setup({
                    autocmd = {
                        enabled = true
                    }
                })
            end
        }, {
            -- LSP Status indicator
            'j-hui/fidget.nvim',
            config = function() require"fidget".setup {} end
        }, {
            'neovim/nvim-lspconfig', -- Config
            config = [[require('plugins.lsp')]]
        }
    }

    -- Buffer line
    -- use {
    --     'akinsho/bufferline.nvim',
    --     tag = "v2.*",
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function() require("bufferline").setup {} end
    -- }

    -- Completion

    use {
        'onsails/lspkind-nvim', -- Pretty icons
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-omni',
        'hrsh7th/cmp-nvim-lsp-signature-help', {
            'hrsh7th/nvim-cmp',
            config = [[require('plugins.nvim-cmp')]]
        }
    }

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Comments
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    -- autopairs
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    -- Tree-sitter
    use {
        'JoosepAlviste/nvim-ts-context-commentstring', {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = [[require('plugins.nvim-treesitter')]]
        }
    }

    -- Formatting
    -- use {
    --     'mhartington/formatter.nvim',
    --     config = [[require('plugins.formatter-nvim')]]
    -- }

    use {
        'davinche/whitespace-vim',
        config = [[require('plugins.whitespace-vim')]]
    }

    -- Terminal
    use {
        "akinsho/toggleterm.nvim",
        config = [[require('plugins.nvim-toggleterm')]]
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = [[require('plugins.gitsigns-nvim')]]
    }
    use {
        'tpope/vim-fugitive',
        config = [[require('plugins.vim-fugitive')]]
    }
    use {
        'TimUntersberger/neogit',
        config = [[require('plugins.neogit')]]
    }
    use {
        'f-person/git-blame.nvim',
        config = [[require('plugins.git-blame-nvim')]]
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Indent lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = [[require('plugins.indent-blankline-nvim')]]
    }

    -- Handy stuff
    use {
        'ygm2/rooter.nvim',
        config = function() vim.g.outermost_root = false end
    }
    use {'dhruvasagar/vim-table-mode'}
    use {'tpope/vim-eunuch'}

    use {
        "folke/which-key.nvim",
        config = [[require('plugins.which-key')]]
    }

    use {
        "folke/zen-mode.nvim",
        config = [[require('plugins.zen-mode-nvim')]]
    }

    use {
        "folke/twilight.nvim",
        config = [[require('plugins.twilight-nvim')]]
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup() end
    }

    -- Statusline
    -- use {
    --     'ojroques/nvim-hardline',
    --     config = [[require('plugins.hardline')]]
    -- }

    use {
        'hoob3rt/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        },
        config = [[require('plugins.lualine')]]
    }

    -- Folding
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = [[require('plugins.nvim-ufo')]]
    }

    -- Color highlighting
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }

    -- Colorschemes
    use {
        'Th3Whit3Wolf/onebuddy',
        requires = {'tjdevries/colorbuddy.vim'}
    }
    use {'RRethy/nvim-base16'}
    use {'NTBBloodbath/doom-one.nvim'}
    use {'folke/tokyonight.nvim'}
    use {'marko-cerovac/material.nvim'}

    use {
        'kyazdani42/nvim-web-devicons',
        config = [[require('plugins.nvim-web-devicons')]]
    }

    -- package.json
    use 'vuki656/package-info.nvim'

    -- Blade
    use {'Eduruiz/vim-blade'}

    -- org-mode
    use {
        'kristijanhusak/orgmode.nvim',
        config = [[require('plugins.orgmode-nvim')]]
    }

    -- DAP
    use 'mfussenegger/nvim-dap'
    use 'Pocco81/dap-buddy.nvim'
    use 'rcarriga/nvim-dap-ui'

end)
