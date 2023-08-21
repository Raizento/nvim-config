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
}, { prefix = "<Leader>" })

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
      l = { telescope.loclist, "loclist" },
      t = { telescope.tags, "tags" },
      j = { telescope.jumplist, "jumps" },
    }
  }, { prefix = "<Leader>" })
end
