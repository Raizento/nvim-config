local gitsigns_status, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status then
  print("Could not load GitSigns!")
  return
end

gitsigns.setup({
  on_attach = function(bufnr)
    local whichkey_status, whichkey = pcall(require, "which-key")
    if not whichkey_status then
      return
    end

    local gs = package.loaded.gitsigns

    whichkey.register({
      g = {
        s = { gs.stage_hunk, "stage hunk" },
        r = { gs.reset_hunk, "reset hunk" },
        S = { gs.stage_buffer, "stage buffer" },
        u = { gs.undo_stage_hunk, "undo stage hunk" },
        R = { gs.reset_buffer, "reset buffer" },
        P = { gs.preview_buffer, "preview buffer" },
        b = {
          function()
            gs.blame_line({ full = true })
          end,
          "blame line",
        },
        d = { gs.diffthis, "diff" },
        D = { gs.diffthis("~"), "diff" },
        t = {
          name = "Toggle",
          b = { gs.toggle_current_line_blame, "toggle blame" },
          d = { gs.toggle_deleted, "toggle deleted" },
        },
        p = {
          function()
            if vim.wo.diff then
              return "p"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end,
          "previous hunk",
          expr = true,
        },
        n = {
          function()
            if vim.wo.diff then
              return "n"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end,
          "next hunk",
          expr = true,
        },
      },
      ih = { "<CMD>Gitsigns select_hunk<CR>", "select hunk", mode = { "o", "x" } },
    }, { prefix = "<Leader>", buffer = bufnr })
  end,
})
