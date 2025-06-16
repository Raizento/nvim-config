local yd = require("yo-dawg")

describe("Test", function()
  it("Test", function()
    local nvim = yd.start()
    yd.stop(nvim)
  end)
end)
