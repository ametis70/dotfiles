local utils = require('utils')

utils.map('n', '<leader>cxx', '<cmd>TroubleToggle<CR>')
utils.map('n', '<leader>cxw', '<cmd>TroubleToggle lsp_workspace_diagnostics<CR>')
utils.map('n', '<leader>cxd', '<cmd>TroubleToggle lsp_document_diagnostics<CR>')
utils.map('n', '<leader>cxq', '<cmd>TroubleToggle quickfix<CR>')
utils.map('n', '<leader>cxl', '<cmd>TroubleToggle loclist<CR>')
utils.map('n', '<leader>cr', '<cmd>TroubleToggle lsp_references<CR>')
