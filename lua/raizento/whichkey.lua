<<<<<<< HEAD
local status, whichkey = pcall(require, "which-key")

if not status then
  print("Which-key could not be found!")
  return
end

whichkey.register({
  ["::"] = { "q:", "command history" },
  ["//"] = { "q/", "fwd search history" },
  ["??"] = { "q?", "bwd search history" },
})

whichkey.register({
  w = { ":w<CR>", "write file" },
  q = { ":q<CR>", "quit" },
  B = { "<CMD>Telescope file_browser<CR>", "Telescope file browser" },
}, { prefix = "<Leader>" })

whichkey.register({
    t = "TreeSitter" ,
}, { prefix = "<Leader>"})

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
      l = { function()
              vim.diagnostic.setloclist({ open = false })
              telescope.loclist()
            end , "loclist" },
      t = { telescope.tags, "tags" },
      j = { telescope.jumplist, "jumps" },
      s = { telescope.search_history, "search history" },
    }
  }, { prefix = "<Leader>" })
end

whichkey.register({
  g = {
    name = "Git",
  }
}, { prefix = "<Leader>" })

local lazygit_status, _ = pcall(require, "lazygit")
if lazygit_status then
  whichkey.register({
    gl = { "<CMD>LazyGit<CR>", "lazygit" },
    gr = { "<CMD>Telescope lazygit<CR>", "repositories (lazygit)" },
  }, { prefix = "<Leader>" })
end
