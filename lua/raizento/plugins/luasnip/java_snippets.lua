local ls = require("luasnip")

local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt

local private_final_field = function(position, node_reference)
  return d(position, function(args)
    local text = args[1][1]
    local first_letter = string.sub(text, 1, 1)
    local result = string.lower(first_letter) .. string.sub(text, 2)

    return sn(1, { i(1, result) })
  end, { node_reference })
end

local log = function(position, node_reference)
  return d(position, function(args)
    local text = args[1][1]
    local _, number_of_brace_pairs = text:gsub("{}", "")

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

return {
  ls.s("prf", fmt("private final {} {};", { i(1), private_final_field(2, 1) })),
  ls.s("log", fmt([[log.{}("{}"{});]], { c(1, log_level_choices), i(2), log(3, 2) })),
}
