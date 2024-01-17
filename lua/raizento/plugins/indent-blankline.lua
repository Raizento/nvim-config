local M = {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    main = "ibl",
}

M.config = function()
    require("ibl").setup({
        scope = {
            show_start = false,
            show_end = false,
        }
    })
end

return M
