local M = {
  "nvim-java/nvim-java"
}

M.config = function()
  require("java").setup()
end

return M
