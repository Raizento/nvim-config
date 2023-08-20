local jdtls_version = '1.9'
local lsp_path = vim.fn.stdpath('config') .. '/lsp/'
local path_to_jdtls = lsp_path .. 'jdtls/'
local jdtls_addons_path = path_to_jdtls .. 'addons/'

local fn = vim.fn

local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but file/dir exists
            return true
        end
    end
    return ok, err
end

local ok, _ = exists(lsp_path)
if not ok then
    os.execute("mkdir " .. lsp_path)
end

-- Install jdtls if it does not exist
ok, _ = exists(path_to_jdtls)
if not ok then
    vim.notify("Downloading jdtls, please wait...")
    fn.system({"mkdir", path_to_jdtls})
    fn.system({"mkdir", jdtls_addons_path})
    fn.system({"wget", "-qP", path_to_jdtls, "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz"})
    fn.system({"wget", "-qP", jdtls_addons_path, "https://projectlombok.org/downloads/lombok.jar"})


    -- These two commands don't work with vim.fn.system - don't know why yet
    os.execute("tar -xvf " .. path_to_jdtls .. "*jdt-language-server* -C " .. path_to_jdtls .. " > /dev/null")
    os.execute("rm " .. path_to_jdtls .. "*.tar.gz")

    fn.system({"rm", path_to_jdtls .. "*.tar.gz"})
end


local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- This will place the Workspace directory for jdtls into your HOME directory
local workspace_dir = path_to_jdtls .. '/workspace/' .. project_name

print(jdtls_addons_path .. "lombok.jar")

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
	'-javaagent:' .. jdtls_addons_path .. 'lombok.jar', 

        '-jar', path_to_jdtls .. 'plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',

        '-configuration', path_to_jdtls .. 'config_linux',

        '-data', workspace_dir,

    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    settings = {
        java = {

        }
    },

    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)
