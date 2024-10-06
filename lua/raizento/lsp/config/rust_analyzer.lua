local M = {}

-- Do not set up rust_analyzer; rustacean does that
M.config = function(capabilities, on_attach)
  return function() end
end

return M
