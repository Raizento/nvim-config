-- TODO This does not work yet but I don't know why
-- nvim:exec_lua([[
--   vim.api.nvim_create_autocmd(
--   { "User" }, {
--     pattern = "LazyDone",
--     callback = function(ev)
--      vim.g.raizento = { lazy_done = true }
--     end
--   })
-- ]], {})

local yd = require("yo-dawg")

describe("Telescope tests", function()
  local nvim

  before_each(function()
    nvim = yd.start()
  end)

  after_each(function()
    yd.stop(nvim)
  end)

  it("Properly opens git file selector", function()
    nvim:cmd({ cmd = "normal", args = { "1 ff" } }, {})
    local filetype = nvim:get_option_value("filetype", { buf = 0 })
    assert.is_equal("TelescopePrompt", filetype)
  end)
end)
