local M = {}

function M.list(open_after)
	local config = {
		previewer = false,
		layout_config = { width = 0.8, prompt_position = "top" },
		prompt_title = " Zoxide",
	}
	if open_after then
		config.attach_mappings = function()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			actions.select_default:replace(function(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				if selection == nil then
					return
				end
				actions.close(prompt_bufnr)
				vim.schedule(function()
					require("fzf-lua").live_grep_glob({
            multiprocess = true,
						cwd = selection.path,
						no_header = true,
						no_header_i = true,
					})
				end)
			end)
			return true
		end
	end
	require("telescope").extensions.zoxide.list(require("telescope.themes").get_dropdown(config))
end

return M
