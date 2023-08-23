local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
    print("Could not load lualine!")
    return
end

lualine.setup{ }
