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
    name = "Diagnostic",
    e = { vim.diagnostic.open_float, "Open float", },
    p = { vim.diagnostic.goto_prev, "Previous", },
    n = { vim.diagnostic.goto_next, "Next", },
    q = { vim.diagnostic.setloclist, "Open loclist", },
  },
}, { prefix = "<Leader>" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    
    whichkey.register({
      K = { vim.lsp.buf.hover, "Hover" },
      ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
    }, { buffer = ev.buf})

    whichkey.register({
      l = {
        name = "LSP",
        w = {
          name = "Workspace",
          a = { vim.lsp.buf.add_workspace_folder, "Add folder", },
          r = { vim.lsp.buf.remove_workspace_folder, "Remove folder", },
          l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List folders", },
        },
        a = { vim.lsp.buf.code_action, "Actions", mode = { "n", "v", } },
        f = { function() vim.lsp.buf.format { async = true } end, "Format" },
      }
    }, { buffer = ev.buf, prefix = "<Leader>" })

    whichkey.register({
      j = {
        name = "jump to",
        D = { vim.lsp.buf.declaration, "Declaration" },
        d = { vim.lsp.buf.definition, "Definition" },
        i = { vim.lsp.buf.implementation, "Implementation" },
        r = { vim.lsp.buf.references, "References" },
        t = { vim.lsp.buf.type_definition, "Type definition" },
    }, { buffer = ev.buf, prefix = "<Leader>" })
  end
})
