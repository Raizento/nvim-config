---@class JdtlsConfig
---@field formatting_settings_path string Path to the formatting file jdtls should use
local JdtlsConfig = {
}

function JdtlsConfig:new(o)
  o = o or {}

  setmetatable(o, self)
  self.__index = self

  o.formatting_settings_path = o.formatting_settings_path or ""

  return o
end

return JdtlsConfig
