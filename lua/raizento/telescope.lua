local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  print("Could not load telescope!")
  return
end

telescope.setup({
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
})

telescope.load_extension("file_browser")
