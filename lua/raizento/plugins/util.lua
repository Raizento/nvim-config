local Plugin = require("raizento.plugins.plugin")

local Node = {}

function Node:new(o)
  o = o or {}

  setmetatable(o, self)
  self.__index = self

  o.plugin = o.plugin or {}
  o.incoming_edges = o.incoming_edges or 0
  o.next = o.next or {}

  return o
end

local M = {}

M.topological_order = function(plugins)
  local nodes = {}

  local start_nodes = {}

  -- First loop that transforms all plugins into nodes so that we can construct
  -- an acyclic directed graph out of them
  -- Dependencies which aren't also proper plugins (plugins which provide more
  -- information than just the url) will first be transformed into a plugin and
  -- then wrapped into a node to make working on all nodes easier
  for _, plugin in pairs(plugins) do
    local node = Node:new({ plugin = plugin })

    nodes[plugin.url] = node

    -- Add the dependency to the nodes list already
    -- If the dependency is a proper plugin we have configuration for, it will
    -- be overwritten by the node containing the proper plugin later on
    local dependencies = plugin.dependencies or {}
    for _, dependency in pairs(dependencies) do
      local url = nil

      if type(dependency) == "string" then
        url = dependency
      elseif type(dependency) == "table" then
        url = dependency.url
      end

      -- TODO This doesn't work if we have some configuration file for the plugin
      if not nodes[url] then
        local plugin = type(dependency) == "string" and Plugin:new({ url = url }) or Plugin:new(dependency)

        local node = Node:new({ plugin = plugin })
        nodes[url] = node
      end
    end
  end

  -- Split into nodes and start_nodes
  for url, node in pairs(nodes) do
    if not node.plugin:has_dependencies() then
      nodes[url] = nil
      start_nodes[url] = node
      goto continue
    end

    node.incoming_edges = #node.plugin.dependencies

    for _, dependency in ipairs(node.plugin.dependencies) do
      local dependency_url = type(dependency) == "string" and dependency or dependency.url
      -- Since we can depend on proper plugins or raw dependencies, we have to
      -- look in both tables since raw dependencies will already be in start_nodes
      local dependency_node = nodes[dependency_url] or start_nodes[dependency_url]
      table.insert(dependency_node.next, node.plugin.url)
    end

    ::continue::
  end

  local order = {}

  while not vim.tbl_isempty(start_nodes) do
    local url, node = vim.iter(start_nodes):take(1):next()
    start_nodes[url] = nil

    table.insert(order, node.plugin)

    local next_nodes = node.next or {}
    for _, next in pairs(next_nodes) do
      local next_node = nodes[next]
      next_node.incoming_edges = next_node.incoming_edges - 1
      if next_node.incoming_edges == 0 then
        start_nodes[next_node.plugin.url] = next_node
      end
    end
  end

  return order
end

return M
