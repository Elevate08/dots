local lsp = require('lspconfig')
local completion = require('completion')

local custom_attach = function()
    completion.on_attach()
    -- Python specifically isn't setting omnifunc correctly, ftplugin conflict
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lsp.pyls.setup{on_attach=custom_attach}
lsp.jsonls.setup{on_attach=custom_attach}
lsp.bashls.setup{on_attach=custom_attach}
lsp.yamlls.setup{on_attach=custom_attach}
lsp.tsserver.setup{on_attach=custom_attach}
