require("raizento.util.patches")

vim.cmd.packadd("nvim.undotree")

require("raizento.core")
require("raizento.autocmds")
require("raizento.plugins")

require("raizento.diagnostics")
require("raizento.lsp")
