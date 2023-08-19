vim.g.mapleader = " " 

vim.g.coq_settings = {
  auto_start = "shut-up",
  display = {
    preview = {
      border = {
	  {"", "NormalFloat"},
	  {"", "NormalFloat"},
	  {"", "NormalFloat"},
	  {" ", "NormalFloat"},
	  {"", "NormalFloat"},
	  {"", "NormalFloat"},
	  {"", "NormalFloat"},
	  {" ", "NormalFloat"}
      },
      positions = { 
	  east = 1, 
	  south = 2,
	  north = 3,
	  west = 4,
      },
    },
  },
}
