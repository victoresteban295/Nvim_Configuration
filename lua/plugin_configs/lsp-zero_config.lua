local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig')['jdtls'].setup {}

lsp.setup()

-- Delete This to enable popup warning/errors 
vim.diagnostic.config({
    virtual_text = false,
})
