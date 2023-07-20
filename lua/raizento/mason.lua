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
