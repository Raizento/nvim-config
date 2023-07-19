require("mason").setup({
    ui = {
        icons = {
            package_installed = "󰄵",
            package_pending = "󰪞",
            package_uninstalled = "󰄱"
        }
    }
})

require("mason-lspconfig").setup()

-- Rust tools setup
-- Sets up the rust-analyzer lsp; do not setup manually!
local rt = require("rust-tools")
