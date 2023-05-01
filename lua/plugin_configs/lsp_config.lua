-- Config file for the following LSP Plugins: 
--      mason.nvim
--      mason-lspconfig.nvim
--      nvim-lspconfig

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls"}
})

local on_attach = function (_, _)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {}) -- Gives Documentation
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {})
    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
    vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", {})
end

require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    settings= {
        Lua = {
            diagnostics = {
                -- Get Language Server to Recognize the 'vim' global
                globals = {'vim'},
            },
        },
    },
}

-- NOTE-TO-SELF: Don't Uncomment, Adding This Causes 2 LSP Servers to attach to Buffer with Java File
--[[ require("lspconfig").jdtls.setup { ]]
--[[     on_attach = on_attach ]]
--[[ } ]]
