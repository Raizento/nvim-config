local fs = require("raizento.util.fs")

describe("fs module", function()
  describe("does file exist tests", function()
    it("true when file exists", function()
      local name = os.tmpname()
      local file = io.open(name, "w")
      assert.is_true(fs.does_file_exist(name))
    end)

    it("false when file does not exist", function()
      assert.is_false(fs.does_file_exist("./this_file_does_not_exist.lua"))
    end)
  end)

  describe("remove file extension tests", function()
    for _, args in pairs({
      { expected = "test", filename = "test.lua" },
      { expected = ".test", filename = ".test.lua" },
    }) do
      it("properly removes file ending", function()
        local name_without_extension = fs.remove_file_extension(args.filename)
        assert.is_equal(args.expected, name_without_extension)
      end)
    end

    for _, args in pairs({
      { expected = "test", filename = "test" },
      { expected = ".test", filename = ".test" },
    }) do
      it("does not remove anything when file does not have an extension", function()
        local name_without_extension = fs.remove_file_extension(args.filename)
        assert.is_equal(args.expected, name_without_extension)
      end)
    end

    for _, args in pairs({
      { expected = "test", filename = "test.tar.gz" },
      { expected = ".test", filename = ".test.tar.gz" },
    }) do
      it("properly removes compound extensions", function()
        local name_without_extension = fs.remove_file_extension(args.filename)
        assert.is_equal(args.expected, name_without_extension)
      end)
    end
  end)

  describe("is filetype tests", function()
    it("true when file is filetype", function()
      local filename = "test.lua"
      assert.is_true(fs.is_filetype(filename, { "lua" }))
    end)

    it("true when file is filetype and multiple filetypes are provided", function()
      local filename = "test.lua"
      assert.is_true(fs.is_filetype(filename, { "rs", "lua", "c" }))
    end)

    it("false when file is not filetype", function()
      local filename = "test.lua"
      assert.is_false(fs.is_filetype(filename, { "c" }))
    end)

    it("false when not filetypes provided", function()
      local filename = "test.lua"
      assert.is_false(fs.is_filetype(filename, {}))
    end)

    it("false when not filetypes provided and file has no extension", function()
      local filename = "test"
      assert.is_false(fs.is_filetype(filename, {}))
    end)
  end)
end)
