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
        init = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 300
        end,
        config = function()
            local whichkey = require("which-key")

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
                    t = "Toggle",
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
            require("onedark").load()
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
            "delphinus/cmp-ctags",
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Additional snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match(" %s")
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {},
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    {
                        name = "ctags",
                        option = {
                            executable = "ctags",
                            trigger_characters = { "." },
                            trigger_characters_ft = {},
                        },
                    },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            function leave_snippet()
                if
                    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
                    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                    and not require("luasnip").session.jump_active
                then
                    require("luasnip").unlink_current()
                end
            end

            -- stop snippets when you leave to normal mode
            vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])
        end,
    },

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
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        -- TODO add rules with TreeSitter support?
        config = function()
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

            vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "InsertLeave"}, {
                callback = function()
                    vim.opt.foldmethod = "expr"
                    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
                end,
                desc = "Folding with TreeSitter"
            })

            require("nvim-autopairs").setup({})
            local cmp = require("cmp")
            local autopairs = require("nvim-autopairs.completion.cmp")

            cmp.event:on("confirm_done", autopairs.on_confirm_done())
        end,
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

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, lhs, rhs, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    map("n", "<Leader>gs", gs.stage_hunk, { desc = "stage hunk" })
                    map("n", "<Leader>gr", gs.reset_hunk, { desc = "reset hunk" })
                    map("n", "<Leader>gS", gs.stage_buffer, { desc = "stage buffer" })
                    map("n", "<Leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                    map("n", "<Leader>gR", gs.reset_buffer, { desc = "reset buffer" })
                    map("n", "<Leader>gP", gs.preview_hunk, { desc = "preview hunk" })
                    map("n", "<Leader>gb", function() gs.blame_line({ full = true }) end, { desc = "blame line" })
                    map("n", "<Leader>gd", gs.diffthis, { desc = "diff" })
                    map("n", "<Leader>gD", function() gs.diffthis("~") end, { desc = "diff" })
                    map("n", "<Leader>gtb", gs.toggle_current_line_blame, { desc = "toggle line blame" })
                    map("n", "<Leader>gtd", gs.toggle_deleted, { desc = "toggle deleted" })
                    map("n", "[g",
                        function()
                            if vim.wo.diff then
                                return "p"
                            end
                            vim.schedule(function()
                                gs.prev_hunk()
                            end)
                            return "<Ignore>"
                        end,
                        { desc = "toggle deleted", expr = true })
                    map("n", "]g",
                        function()
                            if vim.wo.diff then
                                return "n"
                            end
                            vim.schedule(function()
                                gs.next_hunk()
                            end)
                            return "<Ignore>"
                        end,
                        { desc = "toggle deleted", expr = true })
                    map({"o", "x"}, "<Leader>gih", gs.select_hunk, { desc = "select hunk" })
                end,

            })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },

    {
        "alexghergh/nvim-tmux-navigation",
        config = true,
        keys = {
            { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "L"},
            { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "J"},
            { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "K"},
            { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "R"},
        }
    }
})
