vim.keymap.set(
  "n",
  "<Localleader>s",
  [["sd$a" +<ESC>o"<ESC>"sp]],
  { desc = "split string into two lines starting from cursor position" }
)

require("raizento.util.string")

if vim.fn.exepath("jdtls"):is_empty() and not vim.o.jdtls_message_shown then
  vim.o.jdtls_message_shown = true
  vim.print("To use JDTLS, please install JDTLS via Mason: MasonInstall jdtls")
  return
end

-- Only for LSP folder
-- TODO this fires whenever nvim is loaded; not good; should only fire if jdtls starts
if vim.fn.exepath("java"):is_empty() and not vim.env.JAVA_HOME then
  error("To run JDTLS, you need to have Java installed.")
end

local jdtls_install_path = vim.env.MASON .. "/packages/jdtls/"

-- TODO not a big fan of this; this is very dependent on mason's structure to stay the same
local jdtls_package = require("mason-registry").get_package("jdtls").spec
local equinox_launcher_path = jdtls_install_path
  .. jdtls_package.share["jdtls/plugins/org.eclipse.equinox.launcher.jar"]
local config_path = jdtls_install_path .. jdtls_package.source.download[2].config
local lombok_path = jdtls_install_path .. jdtls_package.share["jdtls/lombok.jar"]

-- TODO all of this does not work if data/lsp is not there
local data_path = vim.fn.stdpath("data")
local workspace_root = data_path .. "/lsp/jdtls/"

local does_workspace_root_exist = vim.uv.fs_stat(workspace_root)

if not does_workspace_root_exist then
  vim.uv.fs_mkdir(workspace_root, tonumber("755", 8))
  vim.print("Created workspace root for jdtls")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local project_workspace = workspace_root .. project_name

local config = {
  cmd = {
    vim.fn.exepath("java"),
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "--enable-native-access=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,

    "-jar",
    equinox_launcher_path,
    "-configuration",
    config_path,

    "-data",
    project_workspace,
  },
}

require("jdtls").start_or_attach(config)
