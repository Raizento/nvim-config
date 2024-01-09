local M = {
    "navarasu/onedark.nvim",
    priority = 1000,
}

M.config = function()
    require("onedark").load()
end

return M
