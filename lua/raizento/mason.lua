require("mason").setup({
    ui = {
        icons = {
            package_installed = "󰄵",
            package_pending = "󰪞",
            package_uninstalled = "󰄱"
        }
    }
})

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "gradle_ls", "groovyls", "jdtls" },
}

-- Rust tools setup
-- Sets up the rust-analyzer lsp; do not setup manually!
local rt = require("rust-tools")

local lspconfig = require("lspconfig")
lspconfig.gradle_ls.setup{}
lspconfig.groovyls.setup{}
lspconfig.jdtls.setup{}

local whichkey = require("which-key")

-- Global keybinds
whichkey.register({
    d = {
        name = "diagnostic",
        e = { vim.diagnostic.open_float, "Open float" },
        q = { vim.diagnostic.setloclist, "Open diagnostic location list" },
    }
}, { prefix = "<leader>" })

whichkey.register({
    ["[d"] = { vim.diagnostic.goto_prev, "Diag: go to previous" },
    ["]d"] = { vim.diagnostic.goto_next, "Diag: go to next" },
})

-- Buffer keybinds
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        --local whichkey = require("which-key")
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        whichkey.register({
            K = { vim.lsp.buf.hover, "Hover" },
            ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" }
        }, { buffer = ev.buf })

        whichkey.register({
            name = "workspace",
            W = {
                a = { vim.lsp.buf.add_workspace_folder, "Add folder" },
                r = { vim.lsp.buf.remove_workspace_folder, "Remove folder" },
                l = { 
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    "List folders"
                },
            }
        }, { prefix = "<leader>", buffer = ev.buf})

        whichkey.register({
            name = "jump to",
            j = {
                D = { vim.lsp.buf.declaration, "Declaration" }, 
                d = { vim.lsp.buf.definition, "Definition" },
                i = { vim.lsp.buf.implementation, "Implementation" },
                r = { vim.lsp.buf.references, "References" },
                t = { vim.lsp.buf.type_definition, "Type definition" }
            }
        }, { prefix = "<leader>", buffer = ev.buf })

        whichkey.register({
            name = "code",
            c = {
                a = { vim.lsp.buf.code_action, "Actions", mode = { "n", "v" }},
                f = { 
                    function()
                        vim.lsp.buf.format { async = true }
                    end,
                    "Format"
                },
            }
        }, { prefix = "<leader>", buffer = ev.buf })
    end
})
