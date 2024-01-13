local M = {}

M.config = function(capabilities)
    return function()
        require("rust-tools").setup({})
    end
end

return M
