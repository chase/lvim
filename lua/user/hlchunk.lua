local M = {}

M.setup = function()
	local status_ok, hlchunk = pcall(require, "hlchunk")
	if not status_ok then
		return
	end
	hlchunk.setup({
		chunk = {
			enable = false,
		},
		indent = {
			enable = false,
		},
		blank = {
			enable = false,
		},
		context = {
			enable = true,
			chars = {
				"▏",
			},
			style = {
				"#445055",
			},
		},
		line_num = {
			style = {
				"#859289",
			},
		},
	})
end

return M
