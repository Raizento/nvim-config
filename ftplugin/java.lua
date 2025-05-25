vim.keymap.set(
  "n",
  "<Localleader>s",
  [["sd$a" +<ESC>o"<ESC>"sp]],
  { desc = "split string into two lines starting from cursor position" }
)
