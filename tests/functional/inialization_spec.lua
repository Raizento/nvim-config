local yd = require("yo-dawg")

describe("Initialization", function()
  local nvim

  before_each(function()
    nvim = yd.start()
  end)

  after_each(function()
    yd.stop(nvim)
  end)

  it("Are all config values set properly?", function()
    local is_test = nvim:cmd({ cmd = "lua", args = { "=require('raizento.config').is_test" } }, { output = true })
    local is_lazy_done = nvim:cmd(
      { cmd = "lua", args = { "=require('raizento.config').is_lazy_done" } },
      { output = true }
    )

    assert.is_equal("true", is_test)
    assert.is_equal("true", is_lazy_done)
  end)
end)
