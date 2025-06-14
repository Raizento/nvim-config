local e, busted = pcall(require, "busted")
for key, value in pairs(busted) do
  vim.print(key)
  vim.print(value)
end
require("raizento")
