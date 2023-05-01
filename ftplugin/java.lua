-- Local Variables 
local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_mac"
local path_to_plugins = jdtls_path .. "/plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
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

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ 'mvnw', 'gradlew', "pom.xml", "build.gradle"}),
    --[[ capabilities = capabilities ]]

}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
