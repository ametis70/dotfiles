local utils = require("utils")
local opts = { noremap = true, silent = true }

utils.map('n', '<leader><space>', '<cmd>lua require("fzf-lua").files()<CR>', opts)
utils.map('n', '<leader>/', '<cmd>lua require("fzf-lua").live_grep()<CR>', opts)
utils.map('n', '<leader>,', '<cmd>lua require("fzf-lua").buffers()<CR>', opts)
utils.map('n', '<leader>bb', '<cmd>lua require("fzf-lua").buffers()<CR>', opts)
utils.map('n', '<leader>hh', '<cmd>lua require("fzf-lua").help_tags()<CR>', opts)
utils.map('n', '<leader>hm', '<cmd>lua require("fzf-lua").man_pages()<CR>', opts)
utils.map('n', '<leader>fp', '<cmd>lua require("fzf-lua").files({ cwd = "~/.config/nvim/" })<CR>', opts)

require'fzf-lua'.setup {
  fzf_layout = 'default',
  grep = {
    rg_opts = "--hidden --column --line-number --no-heading " ..
              "--color=always --smart-case -g '!{.git,node_modules}/*'",
  }
}
