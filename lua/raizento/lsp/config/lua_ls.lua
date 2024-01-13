local M = {}

M.config = function(capabilities)
    return function()
        require("neodev").setup({})
        require("lspconfig").lua_ls.setup({
            capabilities = capabilities
        })
    end
end

return M
