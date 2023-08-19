local lsp_status, lsp = pcall(require, "lspconfig")
local coq_status, coq = pcall(require, "coq")

if not lsp_status then
  print("Could not load LspConfig!")
  return
end

lsp.pyright.setup(coq.lsp_ensure_capabilities())
