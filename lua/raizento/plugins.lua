-- Bootstrapping of packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Dependencies and nice to haves
    use "nvim-lua/plenary.nvim"
    use "nvim-tree/nvim-web-devicons"
    use "BurntSushi/ripgrep"
    use "MunifTanjim/nui.nvim"

    -- Autoclose brackets
    use "m4xshen/autoclose.nvim"

    -- Debugging
    use "mfussenegger/nvim-dap"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = "TSUpdate"
    }

    -- LSP 
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate"
    }
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"

    -- Autocompletion and Snippets
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"

    use {
        "L3MON4D3/LuaSnip",
        tag = "v2.*",
        run = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" }
    }
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"

    use "simrat39/rust-tools.nvim"

    use "mfussenegger/nvim-jdtls"

    use { "folke/neodev.nvim", opts = {} }

    -- Fuzzy Finder
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- File tree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "Muniftanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        -- Show hidden files
                        visible = true,
                    },
                }
            })
        end

    }

    -- Git integration
    use {
        "kdheepak/lazygit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        }
    }

    -- Status line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    -- Colorschemes
    use "projekt0n/github-nvim-theme"
    use "navarasu/onedark.nvim"
    use "folke/tokyonight.nvim"
    use {
        "hardhackerlabs/theme-vim", as = "hardhacker" 
    }

    -- Show key mappings when using keys
    use "folke/which-key.nvim"
    

    if packer_bootstrap then
        require("packer").sync()
    end
end)

