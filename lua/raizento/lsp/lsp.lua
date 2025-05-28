local fs = require("lua.raizento.util.fs")

local config_path = vim.fn.stdpath("config")
local lsp_config_dir = config_path .. "/lsp"

local filenames = fs.get_files_in_directory(lsp_config_dir)
filenames:map(fs.remove_file_extension)

for filename in filenames do
  vim.lsp.enable(filename)
end
