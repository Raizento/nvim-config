require("autoclose").setup({
    keys = {
        ["<"] = { escape = false, close = true, pair = "<>", disabled_filetypes = {} }
    }
})
