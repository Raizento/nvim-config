local devicons_status, devicons = pcall(require, "nvim-web-devicons")
if not devicons_status then
  print("Could not lad DevIcons, continuing without them...")
else
  devicons.setup{}
end
