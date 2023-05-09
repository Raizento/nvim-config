local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    }
    print "Installing packer, close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Protected call so we don't error out on first use
-- also early return in case of failure
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer as a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Plugins go here
return packer.startup(function(use)
    -- Plugin section start --
    use "wbthomason/packer.nvim"    -- Have packer manage itself


    -- color schemes
    use "navarasu/onedark.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use "tyrannicaltoucan/vim-quantum"
    use "hardhackerlabs/theme-vim"
    -- Currently having some issues; check later
    -- use {'hardhackerlabs/theme-vim', as = 'hardhacker'}

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completion
    use "hrsh7th/cmp-path" -- path completion
    use "hrsh7th/cmp-cmdline" -- cmdline completion
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip" -- snippet completion 
    use "rafamadriz/friendly-snippets"

    -- LSP 
    use "williamboman/mason.nvim"
    use "neovim/nvim-lspconfig"
    use "williamboman/mason-lspconfig.nvim"

    -- File tree
    use "nvim-tree/nvim-tree.lua"
    use "nvim-tree/nvim-web-devicons" -- additional icons for nvim-tree

    -- Nicer command line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Tree sitter 
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
end)
