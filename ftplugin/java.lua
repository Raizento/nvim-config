vim.keymap.set(
  "n",
  "<Localleader>s",
  [["sd$a" +<ESC>o"<ESC>"sp]],
  { desc = "split string into two lines starting from cursor position" }
)

require("raizento.util.string")
local fs = require("raizento.util.fs")

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

-- Create workspace root + workspace for project if it does not exist
local data_path = vim.fn.stdpath("data")
local workspace_root = data_path .. "/lsp/jdtls/"

if not fs.does_file_exist(workspace_root) then
  vim.fn.mkdir(workspace_root, "p")
  vim.print("Created workspace root for jdtls")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local project_workspace = workspace_root .. project_name

local create_choose_format_file_command = function()
    vim.api.nvim_create_user_command(
    "ChooseFormatFileForWorkspace",
    function(opts)
      local path = opts.fargs[1] or vim.fn.input('Path to Java format file: ')
      local absolute_path = vim.fs.abspath(path)
      local normalized_path = vim.fs.normalize(absolute_path)

      if not fs.does_file_exist(normalized_path) then
        vim.notify("File at path " .. normalized_path .. " does not exist!", vim.log.levels.ERROR)
        return
      end

      if not vim.endswith(normalized_path, "xml") then
        vim.notify("Configuration file must be xml!", vim.log.levels.ERROR)
        return
      end
      
      local path_object = { formatFilePath = normalized_path }
      path_object = vim.json.encode(path_object)

      -- TODO Read content from file first; this will overwrite any existing config
      local config_file_path = project_workspace .. "/config.json"
      local file = io.open(config_file_path, "w")

      file:write(path_object)
      file:flush()
      file:close()

      vim.notify("Successfully saved config to " .. config_file_path)
    end,
    { nargs='?' }
  )
end

local read_format_file = function()
  local config_file_path = project_workspace .. "/config.json"
  local file = io.open(config_file_path, "r")

  local config = vim.json.decode(file:read("*a"))

  return config.formatFilePath
end


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

  settings = {
    java = {
      format = {
        settings = {
          url = read_format_file(),
        },
      },
    },
  },

  on_init = function(client)
    create_choose_format_file_command()
    vim.lsp.inlay_hint.enable(true)
  end,
}

require("jdtls").start_or_attach(config)
