local fs = require("raizento.util.fs")

local config_path = vim.fn.stdpath("config")
local lsp_config_dir = config_path .. "/lsp"

local filenames = fs.get_files_in_directory(lsp_config_dir)
filenames:map(fs.remove_file_extension)

vim.lsp.config["*"] = {
  on_attach = function(client, bufnr)
    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "S", vim.lsp.buf.hover, { desc = "hover", buffer = bufnr })
    end

    if client:supports_method("textDocument/signatureHelp") then
      vim.keymap.set("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = bufnr })
    end
  end,
}

for filename in filenames do
  vim.lsp.enable(filename)
end
