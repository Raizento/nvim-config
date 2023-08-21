local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status then
  print("Could not load autopairs!")
  return
end

autopairs.setup {}
