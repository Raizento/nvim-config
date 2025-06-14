require("raizento.util.string")

describe("String util", function()
  it("nil is blank", function()
    local text = nil
    assert(string.is_blank(text))
  end)

  it("Empty string is blank", function()
    local text = ""
    assert(string.is_blank(text))
  end)
end)
