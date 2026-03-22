local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/lewis6991/gitsigns.nvim",
  opts = {
    preview_config = {
      border = "none",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  },
}

M.setup = function()
  require("gitsigns").setup(M.opts)

  vim.api.nvim_create_autocmd({ "BufAdd" }, {
    callback = function()
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "<Leader>gs", gs.stage_hunk, { desc = "stage hunk", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gr", gs.reset_hunk, { desc = "reset hunk", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gS", gs.stage_buffer, { desc = "stage buffer", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gR", gs.reset_buffer, { desc = "reset buffer", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gP", gs.preview_hunk, { desc = "preview hunk", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gb", function()
        gs.blame_line({ full = true, buffer = bufnr })
      end, { desc = "blame line", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gd", gs.diffthis, { desc = "diff", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gD", function()
        gs.diffthis("~")
      end, { desc = "diff", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gtb", gs.toggle_current_line_blame, { desc = "toggle line blame", buffer = bufnr })
      vim.keymap.set("n", "<Leader>gtd", gs.toggle_deleted, { desc = "toggle deleted", buffer = bufnr })
      vim.keymap.set("n", "[g", function()
        if vim.wo.diff then
          return "p"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { desc = "previous chunk", buffer = bufnr, expr = true })
      vim.keymap.set("n", "]g", function()
        if vim.wo.diff then
          return "n"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { desc = "next chunk", buffer = bufnr, expr = true })
      vim.keymap.set({ "o", "x" }, "<Leader>gih", gs.select_hunk, { desc = "select hunk", buffer = bufnr })
    end,
  })
end

return Plugin:new(M)
