local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
    "neovim/nvim-lspconfig",
    "navarasu/onedark.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "delphinus/cmp-ctags",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    { "saadparwaiz1/cmp_luasnip",                dependencies = { "rafamadriz/friendly-snippets" } },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
    "mfussenegger/nvim-jdtls",

    "folke/neodev.nvim",
    { "windwp/nvim-autopairs",                   event = "InsertEnter" },
    { "nvim-treesitter/nvim-treesitter",         build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-refactor" },

    -- Telescope
    { "nvim-telescope/telescope.nvim",           dependencies = { "nvim-lua/plenary.nvim" }, },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", },
        config = function()
            require("telescope").load_extension("lazygit")
        end
    },
})
