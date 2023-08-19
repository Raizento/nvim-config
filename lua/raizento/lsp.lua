local lsp_status, lsp = pcall(require, "lspconfig")

if not lsp_status then
  print("Could not load LspConfig!")
  return
end

lsp.pyright.setup {}
