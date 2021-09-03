local utils = require("utils")
local actions = require("telescope.actions")

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    },
  pickers = {
    file_browser = {
      hidden = true
    },
    find_files = {
        find_command={'rg','--ignore','--hidden','--files'}
    },
  }
}

local opts = { noremap = true, silent = true }
utils.map('n', '<leader><space>', '<cmd>Telescope find_files<CR>', opts)
utils.map('n', '<leader>.', '<cmd>Telescope file_browser<CR>', opts)
utils.map('n', '<leader>/', '<cmd>Telescope live_grep<CR>', opts)
utils.map('n', '<leader>,', '<cmd>Telescope buffers<CR>', opts)
utils.map('n', '<leader>bb', '<cmd>Telescope buffers<CR>', opts)
utils.map('n', '<leader>hh', '<cmd>Telescope help_tags<CR>', opts)
utils.map('n', '<leader>hm', '<cmd>Telescope man_pages<CR>', opts)
utils.map('n', '<leader>fp', [[<cmd>lua require('telescope.builtin').find_files{ cwd = '~/.config/nvim/' }<CR>]], opts)
