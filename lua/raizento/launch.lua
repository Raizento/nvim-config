LAZY_PLUGIN_SPEC = {}

function _G.spec(spec)
  table.insert(LAZY_PLUGIN_SPEC, { import = spec })
end
