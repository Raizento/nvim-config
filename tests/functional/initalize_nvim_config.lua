local yd = require("yo-dawg")

local nvim = yd.start()

vim.print("[Initializing Nvim config]\n")

while true do
  local lazy_done = nvim:cmd({ cmd = "lua", args = { "=_G.raizento.lazy_done" } }, { output = true })

  if lazy_done == "true" then
    vim.print("[Initialization successful]\n")
    break
  end

  vim.print("[Waiting...]\n")
  os.execute("sleep 0.2")
end
