local status, whichkey = pcall(require, "which-key")

if not status then
  print("Which-key could not be found!")
  return
end

whichkey.register({
  ["::"] = { "q:", "Command history" },
  ["//"] = { "q/", "Fwd search history" },
  ["??"] = { "q?", "Bwd search history" },
})

whichkey.register({
  w = { ":w<CR>", "Write file" },
  q = { ":q<CR>", "Quit" },
}, { prefix = "<Leader>" })
