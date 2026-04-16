require("raizento.util.patches")

vim.cmd.packadd("nvim.undotree")

require("raizento.core")
require("raizento.autocmds")
require("raizento.plugins")

require("raizento.diagnostics")
require("raizento.lsp")

function _G.tabline()
  local tabline = ""

  for index = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(index)
    local buflist = vim.fn.tabpagebuflist(index)
    local current_buf = buflist[winnr]

    local highlight_group = _G.get_tabpage_hightlight_group(index)
    tabline = tabline .. highlight_group

    tabline = tabline .. "%" .. index .. "T"

    local changed_buffers = _G.get_number_of_changed_buffers(index)
    local changed_marker = string.format(" %d+", changed_buffers)
    if changed_buffers == 0 then
      changed_marker = ""
    end

    local title = _G.get_tabpage_title(current_buf)
    local last_tabpage = index == vim.fn.tabpagenr("#") and "(L)" or ""
    local tabpage_title = string.format(" %s%s %s ", title, changed_marker, last_tabpage)

    tabline = tabline .. tabpage_title
  end

  tabline = tabline .. "%#TabLineFill#%T"

  return tabline
end

---@param tabpagenr integer number of tabpage
---@return string highlight group
function _G.get_tabpage_hightlight_group(tabpagenr)
  if tabpagenr == vim.fn.tabpagenr() then
    return "%#TabLineSel#"
  end

  return "%#TabLine#"
end

function _G.get_tabpage_title(bufnr)
  local bufname = vim.fn.bufname(bufnr)
  bufname = vim.fn.fnamemodify(bufname, ":t")

  -- bufname is empty when in the buffer opened by nvim without passing a filename
  if bufname == "" then
    return "[No Name]"
  end

  return bufname
end

function _G.get_number_of_changed_buffers(tabpagenr)
  local tab_id = vim.api.nvim_list_tabpages()[tabpagenr]
  local wins = vim.api.nvim_tabpage_list_wins(tab_id)
  local buffers = vim.iter(wins):map(function(winid) return vim.fn.winbufnr(winid) end):totable()
  local number_changed = #vim.iter(buffers):filter(function(bufnr) return vim.bo[bufnr].modified end):totable()

  return number_changed
end

vim.opt.tabline = "%!v:lua.tabline()"
