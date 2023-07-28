-- Local Variables 
local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_mac"
local path_to_plugins = jdtls_path .. "/plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar"
local lombok_path = jdtls_path .. "/lombok.jar"

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
--[[ capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities) ]]

-- Method: Checks if Current Project Exists
local function directory_exists(path)
    local f = io.popen("cd " .. path)
    local ff = f:read("*all")

    if ff:find("ItemNotFoundException") then
       return false
    else
        return true
    end
end

-- Path to Unique Per Project Workspace Folder
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') -- Extracts Project Name From its Path
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name -- Creates Path to New Workspace with Project Name

-- Check if Workspace Path already exists, if not Create New One
if directory_exists(workspace_dir) then
else
    os.execute("mkdir " .. workspace_dir)
end

-- Custom Keymaps
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

local config = {
    -- The command that starts the language server
    cmd = {
        '/Users/victoresteban295/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,
        '-configuration', path_to_lsp_server,
        '-data', workspace_dir,
    },
    on_attach = on_attach,

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ 'mvnw', 'gradlew', "pom.xml", "build.gradle"}),
    --[[ capabilities = capabilities ]]

}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
