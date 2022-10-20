local M = {}

M.config = function()
	require("dressing").setup({
		select = {
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return {
						backend = "telescope",
						telescope = require("telescope.themes").get_cursor(),
					}
				end
			end,
		},
    input = {
      get_config = function()
				-- NvimTree bugs out when trying to rename files without this
				if vim.o.filetype == "NvimTree" then
					return { enabled = false }
				end
      end
    }
	})
end

return M
