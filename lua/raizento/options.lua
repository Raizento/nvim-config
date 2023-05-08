-- For further details on single options do
-- :help options
-- and search for the last part of an option name (e.g. /number)
local options = {
    number			= true, -- line numbers
    relativenumber	= true, -- relative line numbers
    ambiwidth 		= "double", -- IMPORTANT! Needs to be double for nerd font to work correctly! 
    autoindent		= true, -- Copy indent from current line when starting a new line
    autoread		= true, -- Automatically read file again if it has been changed outside of Vim
    autowrite		= false, -- Do not automatically write contents on certain commands if file has been modified
    autowriteall	= false, -- Like autowrite but for different commands
    background		= "dark", -- Color groups for TUI, tells Nvim what the inherited (executing terminal) background color looks like
    backspace		= { "indent", "eol", "start" }, -- indent: allow backspacing over autoindent, eol: allow backspacing over line breaks, start: allow backspacing over the start of insert
    backup			= false, -- Do not leave backup around after writing file
    writebackup		= true, -- Create backup before writing to a file, delete after
    binary 			= false, -- Set before editing binary files!
    bomb			= false, -- Byte Order Mark, used by some apps to recognize file encoding, off for better compatibility
    breakat			= " ^I!@*-+;:,./?", -- Choose which characters might cause a line break if 'linebreak' is on
    breakindent		= false, -- Wrapped lines will not be indented the same way as their beginning	
    breakindentopt	= "", -- Settings for 'breakindent'
    browsedir		= "last", -- Which directory to use for the file browser, last = directory where file was opened/saved
    casemap			= { "internal", "keepascii" }, -- Details about changing the case of letters
    cdhome			= false, -- Change dir to ~ or show current current working dir. No effect on UNIX
    cindent			= false, -- automatic C program indenting
    clipboard		= "unnamed", -- use clipboard register "*"
    conceallevel    = 0, -- make backticks visible
    cmdheight		= 1, -- Command-line height at the bottom
    cmdwinheight	= 7, -- Command-line window height
    display			= "lastline", -- Changes how text is displayed
    equalalways		= true, -- All windows are same size after splitting
    expandtab		= true, -- Replace tabs with spaces
    fileencoding	= "utf-8", -- File content encoding
    gdefault		= false, -- Deprecated, off as a safety measure
    guifont			= "Cascadia Mono", -- Font for GUI version of NVim 
    helpheight		= 20, -- Height for help window
    helplang	    = "en", -- Language for help  
    ignorecase      = true, -- Ignore case when searching in a fileencoding
    incsearch       = true, -- Show partial matches while entering search pattern
    magic           = true, -- Plugins most likely break if off
    matchpairs      = "(:),{:},[:],<:>", -- Pairs which are jumped to with the % command
    mouse           = "a", -- Make mouse work in all modes
    numberwidth     = 4, -- Min number of columns used by line numbers
    previewheight   = 12, -- Default height for a preview window
    quoteescape     = "\\", -- Character used to escape quotes in a string
    ruler           = true, -- Show line and column of cursor position
    scrolloff       = 4, -- Lines to keep above and below the cursor when scrolling
    shiftwidth      = 4, -- Number of spaces for tabs
    sidescrolloff   = 8, -- Number of columsn to keep vertical to the cursor
    smartindent     = true, -- automatic indenting after certain characters
    smarttab        = true, -- Tab in front of line insert 'shiftwidth'
    splitright      = true, -- Horizontal split will be right
    splitbelow 		= true, -- split pane will appear below active pane
    tabstop         = 4, -- Number of spaces that a tab in the file counts for
    termguicolors   = true, -- Set GUI colors of terminal
    title           = true, -- Window title will be set to the value of 'titlestring'
    undofile        = true, -- Vim saves undo history to an undo
    wrap            = false, -- Lines too long to be displayed will not be wrapped
}

for option_name, value in pairs(options) do 
	vim.opt[option_name] = value
end

