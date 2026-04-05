local select_keys = {
  {
    { "x", "o" },
    "am",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "im",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end,
  },

  {
    { "x", "o" },
    "ac",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "ic",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end,
  },

  {
    { "x", "o" },
    "ai",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "ii",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
    end,
  },

  {
    { "x", "o" },
    "ap",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "ip",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
    end,
  },
}

local move_keys = {
  {
    { "n", "x", "o" },
    "]m",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[m",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end,
  },

  {
    { "n", "x", "o" },
    "]c",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[c",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end,
  },

  {
    { "n", "x", "o" },
    "]i",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[i",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects")
    end,
  },

  {
    { "n", "x", "o" },
    "]p",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[p",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
    end,
  },
}

local keys = vim.list_extend(select_keys, move_keys)

---@type vpaw.PluginSpec
return {
  url = "https://github.com/nvim-treesitter/nvim-treesitter",
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  },
  hooks = {
    after = {
      install = {
        function()
          vim.cmd("TSUpdate")
        end,
      },
    },
  },
  keys = keys,
  setup = function()
    local treesitter = require("nvim-treesitter")

    -- 0 == executable does not exist
    if vim.fn.executable("tree-sitter") == 0 then
      vim.notify(
        "treesitter-cli needs to be installed to install language parsers; run :checkhealth for more information"
      )
      return
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local filetype = ev.match
        if not vim.tbl_contains(treesitter.get_available(), filetype) then
          return
        end

        treesitter.install({ filetype })
        vim.treesitter.start()

        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-treesitter-textobjects").setup({
      move = {
        set_jumps = true,
      },
    })
  end,
}
