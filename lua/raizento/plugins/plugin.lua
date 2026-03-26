---@class Plugin
---@field url string github url to fetch the plugin from
---@field name? string plugin's main module name
---@field opts? table options to pass into the plugin's setup function
---@field dependencies? (Plugin | string)[] Plugins this plugin depends on to successfully set itself up
---@field keys? table<string, string, function, table> Keymaps
---@field setup? function Moin
---@field hooks? table<"pre" | "after", table<"intall" | "update" | "delete", function>> Hooks to run before/after the plugin was installed/updated/deleted; see :h PackChanged
local Plugin = {}

local get_plugin_name_from_url = function(url)
  -- https://github.com/nvim-telescope/telescope.nvim -> telescope.nvim
  local last_part = string.match(url, "([^/]+)/*$")

  -- telescope.nvim -> telescope
  local base = string.match(last_part, "([^%.]+)")
  return string.lower(base)
end

---@return Plugin
---@param o table
function Plugin:new(o)
  o = o or {}

  if o.url == nil then
    error("Url cannot be nil")
  end

  setmetatable(o, self)
  self.__index = self

  o.name = o.name or get_plugin_name_from_url(o.url)
  o.opts = o.opts or {}
  o.dependencies = o.dependencies or {}
  o.keys = o.keys or {}
  o.setup = o.setup
    or function()
      local success, module = pcall(function()
        return require(o.name)
      end)

      -- Some plugins (like friendly snippets) aren't lua and will error when trying to require them
      -- If they are not lua, exit early since we also cannot set them up
      if not success then
        return
      end

      -- Plugins like e.g. plenary might "shadow" their setup index
      -- using a metatable; use rawget to get the actual function
      local setup = rawget(module, "setup")

      -- Need to make sure that setup it actually a function
      -- E.g. JDTLS' setup entry is a table
      if setup ~= nil and type(setup) == "function" then
        setup(o.opts)
      end
    end

  o.hooks = o.hooks or {}

  return o
end

function Plugin:has_dependencies()
  local dependencies = self.dependencies or {}
  return not vim.tbl_isempty(dependencies)
end

function Plugin:setup_hooks()
  local pre = self.hooks.pre or {}
  for hook_kind, hooks in pairs(pre) do
    for _, hook in pairs(hooks) do
      vim.api.nvim_create_autocmd({ "PackChangedPre" }, {
        callback = function(ev)
          local name, kind = ev.data.spec.name, ev.data.kind

          if name == self.name and kind == hook_kind then
            if not ev.data.active then
              vim.cmd.packadd(self.name)
            end
            hook()
          end
        end,
      })
    end
  end

  local after = self.hooks.after or {}
  for hook_kind, hooks in pairs(after) do
    for _, hook in pairs(hooks) do
      vim.api.nvim_create_autocmd({ "PackChanged" }, {
        callback = function(ev)
          local name, kind = ev.data.spec.name, ev.data.kind

          if name == self.name and kind == hook_kind then
            if not ev.data.active then
              vim.cmd.packadd(self.name)
            end
            hook()
          end
        end,
      })
    end
  end
end

function Plugin:enable()
  self:setup()

  for _, mapping in pairs(self.keys) do
    vim.keymap.set(unpack(mapping))
  end
end

return Plugin
