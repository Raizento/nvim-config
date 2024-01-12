local M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<Leader>e",
            function()
                vim.cmd("Neotree toggle")
            end,
            desc = "toggle/focus neotree"
        }
    }
}

return M
