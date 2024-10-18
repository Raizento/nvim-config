local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<Leader>mp", "<CMD>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "toggle markdown preview" },
  },
}

return M
