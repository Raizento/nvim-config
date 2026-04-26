local ls = require("luasnip")

local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local s = ls.snippet

local fmt = require("luasnip.extras.fmt").fmt

local type_field_node = function(position, node_reference)
  return d(position, function(args)
    local text = args[1][1]
    local first_letter = string.sub(text, 1, 1)
    local result = string.lower(first_letter) .. string.sub(text, 2)

    return sn(position, { i(1, result) })
  end, { node_reference })
end

local log = function(position, node_reference)
  return d(position, function(args)
    local text = args[1][1]
    local _, number_of_brace_pairs = text:gsub("{.-}", "")

    if number_of_brace_pairs == 0 then
      return sn(1, { t("") })
    end

    local nodes = { t(", ") }
    for index = 1, number_of_brace_pairs do
      table.insert(nodes, i(index, "var" .. index))
      table.insert(nodes, t(", "))
    end

    table.remove(nodes, #nodes)

    return sn(1, nodes)
  end, { node_reference })
end

local log_level_choices = {
  t("info"),
  t("debug"),
  t("warn"),
  t("error"),
}

local mapping_string = [[
{}
{} {}({}) {{
    {}
}}
]]

local method_choices = {
  sn(nil, { t('@GetMapping("'), i(1), t('")') }),
  sn(nil, { t('@PostMapping("'), i(1), t('")') }),
  sn(nil, { t('@DeleteMapping("'), i(1), t('")') }),
  sn(nil, { t('@PatchMapping("'), i(1), t('")') })
}

local response_entity_choices = {
  sn(nil, { t('ResponseEntity<'), i(1), t('>') }),
  sn(nil, { i(1) })
}

local request_parameters = function(position, node_reference)
  return d(position, function(args)
    local text = args[1][1]
    -- TODO This does not work correctly
    local _, number_of_path_paramters = text:gsub("{.-}", "")

    if number_of_path_paramters == 0 then
      return sn(position, { i(1, "") })
    end

    local nodes = {}
    for index = 1, number_of_path_paramters do
      table.insert(nodes, i(1 + 2 * (index - 1)))
      table.insert(nodes, t(" "))
      table.insert(nodes, type_field_node(2 + 2 * (index - 1), 1 + 2 * (index - 1)))
      table.insert(nodes, t(", "))
    end

    -- Get rid of the trailing comma
    table.remove(nodes, #nodes)

    return sn(position, nodes)
  end, { node_reference })
end

return {
  s("prf", fmt("private final {} {};", { i(1), type_field_node(2, 1) })),
  s("log", fmt([[log.{}("{}"{});]], { c(1, log_level_choices), i(2), log(3, 2) })),
  s("@/", fmt(mapping_string, {
    c(1, method_choices),
    c(2, response_entity_choices),
    i(3),
    request_parameters(4, 1),
    i(5)
  }))
}
