-- Protected call to set the colorscheme
-- Will notify if colorscheme is not found and load default colorscheme

local colorscheme = "onedark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
