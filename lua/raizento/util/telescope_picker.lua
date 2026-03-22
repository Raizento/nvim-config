local M = {
  ---@param callback function<string> function to call after selection was made
  pick_file_path = function(filetype, callback)
    require("telescope.builtin").find_files({
      prompt_title = "Select file path",
      find_command = {
        "rg",
        "--files",
        "--type",
        filetype
      },
      attach_mappings = function(prompt_bufnr, _)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)

          local entry = action_state.get_selected_entry()

          if not entry then
            return false
          end

          local file_path = entry.path or entry[1]
          callback(file_path)
        end)

        return true
      end
    })
  end
}

return M
