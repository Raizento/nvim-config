local M = {
  "folke/which-key.nvim",
}

M.config = function()
  local wk = require("which-key")
  wk.setup({
    delay = 300,
    icons = {
      mappings = false,
    },
  })

  wk.add({ "<Leader>f", group = "Find" })

  wk.add({ "<Leader>m", group = "Markdown" })

  wk.add({ "<Leader>g", group = "Git" })
  wk.add({ "<Leader>gt", group = "Toggle" })

  wk.add({ "<Leader>j", group = "Jump to" })

  wk.add({ "<Leader>d", group = "Diagnostics" })

  wk.add({ "<Leader>l", group = "LSP" })
  wk.add({ "<Leader>lw", group = "Workspace" })
end

return M
