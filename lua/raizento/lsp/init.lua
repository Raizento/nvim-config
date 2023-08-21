local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("Could not load Mason!")
  return
end

local mason_lsp_config_status, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_config_status then
  print("Could not load mason-lspconfig!")
  return
end

local whichkey_status, whichkey = pcall(require, "which-key")
if not whichkey_status then
  print("Could not load which-key!")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "󰄵",
      package_pending = "󰪞",
      package_uninstalled = "󰄱"
    }
  }
})

local handlers_status, handlers = pcall(require, "raizento.lsp.handlers")
if not handlers_status then
  print("Could not load handlers!")
  return
end

mason_lsp.setup()
mason_lsp.setup_handlers(handlers.handlers)

whichkey.register({
  d = {
    name = "diagnostic",
    e = { vim.diagnostic.open_float, "Open float", },
    p = { vim.diagnostic.goto_prev, "Previous", },
    n = { vim.diagnostic.goto_next, "Next", },
    q = { vim.diagnostic.setloclist, "Open loclist", },
  },
}, { prefix = "<Leader>" })
