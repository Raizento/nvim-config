local lsp_status, lsp = pcall(require, "lspconfig")

if not lsp_status then
  print("Could not load LspConfig!")
  return
end

local cmp_lsp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not lsp_status then
  print("Could not load cmp_nvim_lsp!")
  return
end

local capabilities = cmp_lsp.default_capabilities()

lsp.pyright.setup { capabilities = capabilities, }
