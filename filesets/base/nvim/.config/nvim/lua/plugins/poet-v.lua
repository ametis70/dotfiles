vim.g.poetv_executables = { 'poetry' }
vim.g.poetv_auto_activate = 0
vim.g.poetv_set_environment = 1

function _G.ResetPyright()
    local clients = vim.lsp.get_active_clients()
    for _, client in pairs(clients) do
        if client.name == 'pyright' then
           vim.lsp.reset(client.id)
        end
    end
end

vim.api.nvim_exec([[
augroup poetv_autocmd
  au!
  au WinEnter,BufWinEnter *.py silent |
    if &previewwindow != 1 && expand('%:p') !~# "/\\.git/"
      call poetv#activate() | v:lua.ResetPyright() |
    endif
augroup END
]], true)

return { ResetPyright = _G.ResetPyright }
