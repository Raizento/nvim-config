local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status then
  print("Could not load autopairs!")
  return
end

-- TODO add rules with TreeSitter support?
autopairs.setup {}
