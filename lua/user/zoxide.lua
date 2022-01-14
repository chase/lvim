local M = {}

function M.list(open_after)
  local config = {
		previewer = false,
		layout_config = { width = 0.8, prompt_position = "top" },
		prompt_title = " Zoxide",
	}
	if open_after then
		config.attach_mappings = function()
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local function open_rnvimr()
        local selection = action_state.get_selected_entry()

        vim.schedule(function ()
          vim.fn["rnvimr#open"](selection.path)
        end)
      end
      actions.select_default:enhance({
        post = open_rnvimr
      })
      return true
    end
	end
	require("telescope").extensions.zoxide.list(require("telescope.themes").get_dropdown(config))
end

return M
