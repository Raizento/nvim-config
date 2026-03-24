vim.keymap.set(
  "n",
  "<Localleader>s",
  [["sd$a" +<ESC>o"<ESC>"sp]],
  { desc = "split string into two lines starting from cursor position" }
)

vim.keymap.set("n", "<Leader>fj", function()
  require("telescope.builtin").find_files({
    find_command = {
      "rg",
      "--files",
      "--glob",
      "*.java",
      "--glob",
      "*.properties",
      "--glob",
      "application.*.y(a|)ml",
      "--glob",
      "*.gradle",
      "--glob",
      "!.gradle/*",
    },
  })
end, { buffer = vim.fn.bufnr() })

local JDTLS = "jdtls"
local PICK_FORMAT_KEYMAP = "<Leader>lcf"

local JdtlsConfig = require("raizento.lsp.config.jdtls_config")
local json = require("raizento.util.json")
local telescope_picker = require("raizento.util.telescope_picker")
local fs = require("raizento.util.fs")

local jdtls = require("jdtls")

local jdtls_install_path = vim.env.MASON .. "/packages/" .. JDTLS .. "/"

-- TODO not a big fan of this; this is very dependent on mason's structure to stay the same
local jdtls_package = require("mason-registry").get_package(JDTLS).spec
local equinox_launcher_path = jdtls_install_path
  .. jdtls_package.share[JDTLS .. "/plugins/org.eclipse.equinox.launcher.jar"]

---@diagnostic disable-next-line: undefined-field
local config_path = jdtls_install_path .. jdtls_package.source.download[2].config
local lombok_path = jdtls_install_path .. jdtls_package.share[JDTLS .. "/lombok.jar"]

-- Create workspace root + workspace for project if it does not exist
local data_path = vim.fn.stdpath("data")
local workspace_root = data_path .. "/lsp/" .. JDTLS .. "/"

if not fs.does_file_exist(workspace_root) then
  vim.fn.mkdir(workspace_root, "p")
  vim.print("Created workspace root for jdtls")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local project_workspace = workspace_root .. project_name

local jdtls_config_path = project_workspace .. "/config.json"

if not fs.does_file_exist(project_workspace) then
  vim.fn.mkdir(project_workspace, "p")
  vim.print("Created project workspace for " .. project_name)
end

---@type JdtlsConfig
local config = JdtlsConfig:new(json.read_from_json(jdtls_config_path))

local jdtls_augroup = vim.api.nvim_create_augroup("jdtls", { clear = false })

local jdtls_config = {
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

  -- List of all settings:
  -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
  settings = {
    java = {
      format = {
        settings = {
          url = config.formatting_settings_path,
        },
      },
    },
  },

  ---@type vim.lsp.client.on_init_cb
  on_init = function(_)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local buf_options = vim.b[ev.buf]

        local on_save = buf_options.on_save or {}

        table.insert(on_save, function(ev)
          local client = vim.lsp.get_clients({ name = JDTLS })[1]

          -- Might be the case if client was detached from a file or when server was shut down
          if client == nil then
            return
          end

          local params = vim.lsp.util.make_range_params(0, "utf-16")

          local response = client:request_sync("java/organizeImports", params, 1000, ev.buf) or {}
          if response.err then
            print("Error on organize imports: " .. response.err.message)
            return
          end
          if response.result then
            vim.lsp.util.apply_workspace_edit(response.result, "utf-16")
          end
        end)

        vim.b[ev.buf].on_save = on_save
      end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = jdtls_augroup,
      callback = function(ev)
        vim.keymap.set("n", "<Leader>js", jdtls.super_implementation, { buffer = ev.buf })
      end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = jdtls_augroup,
      callback = function(ev)
        vim.keymap.set("n", PICK_FORMAT_KEYMAP, function()
          telescope_picker.pick_file_path("xml", function(file_path)
            -- User has selected file which is already registered to be the current formatting file
            -- exit early since we don't need to restart the LSP in that case
            if file_path == config.formatting_settings_path then
              return
            end

            local client = vim.lsp.get_clients({ bufnr = vim.fn.bufnr(), name = JDTLS })[1]

            local attached_buffers = client.attached_buffers

            config.formatting_settings_path = file_path
            json.write_as_json(jdtls_config_path, config)

            local lsp_config = vim.lsp.config[JDTLS] --[[@as vim.lsp.Config]]
            lsp_config.settings.java.format.settings.url = config.formatting_settings_path

            -- TODO the restart might not be needed at all; can maybe directly change the value
            vim.lsp.config(JDTLS, lsp_config)
            vim.lsp.enable(JDTLS, false)

            for bufnr, _ in pairs(attached_buffers) do
              vim.api.nvim_buf_call(bufnr, function()
                jdtls.start_or_attach(vim.lsp.config.jdtls)
              end)
            end
          end)
        end, { buffer = ev.buf })
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      callback = function(ev)
        vim.api.nvim_clear_autocmds({ group = jdtls_augroup })
      end,
    })
  end,
}

-- Load this into the config so we can change this later when dynamically changing settings (e.g. the formatting path)
vim.lsp.config(JDTLS, jdtls_config)
jdtls.start_or_attach(vim.lsp.config.jdtls)
