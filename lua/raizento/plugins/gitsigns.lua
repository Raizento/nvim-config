local M = {
  "lewis6991/gitsigns.nvim",
}

M.config = function()
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
      map("n", "<Leader>gb", function()
        gs.blame_line({ full = true })
      end, { desc = "blame line" })
      map("n", "<Leader>gd", gs.diffthis, { desc = "diff" })
      map("n", "<Leader>gD", function()
        gs.diffthis("~")
      end, { desc = "diff" })
      map("n", "<Leader>gtb", gs.toggle_current_line_blame, { desc = "toggle line blame" })
      map("n", "<Leader>gtd", gs.toggle_deleted, { desc = "toggle deleted" })
      map("n", "[g", function()
        if vim.wo.diff then
          return "p"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { desc = "toggle deleted", expr = true })
      map("n", "]g", function()
        if vim.wo.diff then
          return "n"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { desc = "toggle deleted", expr = true })
      map({ "o", "x" }, "<Leader>gih", gs.select_hunk, { desc = "select hunk" })
    end,
  })
end

return M
