local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
    print("Could not load treesitter!")
    return
end

treesitter.setup {
    ensure_installed = { "vim", "vimdoc", "yaml", "toml", "regex", "json", "json5", "html", "gitignore", "gitcommit",
        "gitattributes", "csv", "comment", "bash", },
    auto_install = true,
}
