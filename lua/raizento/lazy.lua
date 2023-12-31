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
  {
    "nvim-tree/nvim-web-devicons",
    config = true,
  },

  {
    "folke/which-key.nvim",
    config = function()
      local whichkey = require("which-key")

      whichkey.register({
        ["<C-h>"] = { "<C-w>h", "move to left window" },
        ["<C-j>"] = { "<C-w>j", "move to lower window" },
        ["<C-k>"] = { "<C-w>k", "move to upper window" },
        ["<C-l>"] = { "<C-w>l", "move to right window" },
      })

      whichkey.register({
        ["::"] = { "q:", "command history" },
        ["//"] = { "q/", "fwd search history" },
        ["??"] = { "q?", "bwd search history" },
      })

      whichkey.register({
        w = { ":w<CR>", "write file" },
        q = { ":q<CR>", "quit" },
        B = { "<CMD>Telescope file_browser<CR>", "Telescope file browser" },
        v = { "<C-w>v", "Split vertically" },
        s = { "<C-w>s", "Split horizontally" },
        c = { "<C-w>c", "Close window" },
      }, { prefix = "<Leader>" })

      whichkey.register({
        t = "TreeSitter",
      }, { prefix = "<Leader>" })

      local telescope_status, telescope = pcall(require, "telescope.builtin")
      if telescope_status then
        whichkey.register({
          f = {
            name = "Find",
            f = { telescope.find_files, "files" },
            g = { telescope.live_grep, "live grep" },
            b = { telescope.buffers, "buffers" },
            h = { telescope.help_tags, "help tags" },
            c = { telescope.commands, "commands" },
            l = {
              function()
                vim.diagnostic.setloclist({ open = false })
                telescope.loclist()
              end,
              "loclist",
            },
            t = { telescope.tags, "tags" },
            j = { telescope.jumplist, "jumps" },
            s = { telescope.search_history, "search history" },
          },
        }, { prefix = "<Leader>" })
      end

      whichkey.register({
        g = {
          name = "Git",
        },
      }, { prefix = "<Leader>" })

      local lazygit_status, _ = pcall(require, "lazygit")
      if lazygit_status then
        whichkey.register({
          gl = { "<CMD>LazyGit<CR>", "lazygit" },
          gr = { "<CMD>Telescope lazygit<CR>", "repositories (lazygit)" },
        }, { prefix = "<Leader>" })
      end
    end,
  },

  {
    "navarasu/onedark.nvim",
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
    priority = 99,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  "delphinus/cmp-ctags",
  "neovim/nvim-lspconfig",

  "L3MON4D3/LuaSnip",
  { "saadparwaiz1/cmp_luasnip", dependencies = { "rafamadriz/friendly-snippets" } },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "simrat39/rust-tools.nvim",
  "mfussenegger/nvim-jdtls",

  "folke/neodev.nvim",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- TODO add rules with TreeSitter support?
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim",
          "vimdoc",
          "yaml",
          "toml",
          "regex",
          "json",
          "json5",
          "html",
          "gitignore",
          "gitcommit",
          "gitattributes",
          "csv",
          "comment",
          "bash",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = false,
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "<Leader>tr",
            },
          },
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      })
      telescope.load_extension("file_browser")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  "lewis6991/gitsigns.nvim",

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
})
