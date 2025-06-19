local yd = require("yo-dawg")

local nvim = yd.start()

vim.print("[Initializing Nvim config]\n")

while true do
  local success, _ = pcall(function()
    return nvim:eval("g:raizento.lazy_done")
  end)
  if success then
    vim.print("[Initialization successful]\n")
    break
  end
  vim.print("[Waiting...]")
  os.execute("sleep 0.2")
end
