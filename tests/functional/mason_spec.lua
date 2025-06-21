local yd = require("yo-dawg")

describe("Mason", function()
  local nvim

  before_each(function()
    nvim = yd.start()
  end)

  after_each(function()
    yd.stop(nvim)
  end)

  it("Does Mason install block?", function()
    nvim:cmd({ cmd = "MasonInstall", args = { "jdtls" } }, { output = true })
  end)
end)
