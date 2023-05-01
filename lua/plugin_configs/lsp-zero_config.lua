local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    if client.name == "jdtls" then
        vim.cmd.LspStop('jdtls')
        return
    end
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--[[ require('lspconfig')['jdtls'].setup {} ]]

lsp.setup()

-- Disable popup warning/errors 
--[[ vim.diagnostic.config({ ]]
--[[     virtual_text = false, ]]
--[[ }) ]]
