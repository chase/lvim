
local function feedkeys(keys)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end
vim.api.nvim_set_keymap("n", "gd", "", {
	silent = true,
	callback = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    if ft ~= "idl" then return end

		local win = vim.api.nvim_get_current_win()
		local cursor = vim.api.nvim_win_get_cursor(win)
		local line = vim.api.nvim_get_current_line()
		local word = vim.fn.expand("<cword>")
		local pos, pos_end = line:find(word, cursor[2] - #word)
		if not pos then
			return
		end
		local space_rpos = line:reverse():find("%s", #line - pos) or #line
		local space_pos = #line - space_rpos + 2
		local fqn = line:sub(space_pos, pos_end)
		local file = fqn:gsub("::", "/") .. ".idl"
		vim.schedule(function()
			vim.cmd("e " .. file)
		end)
	end,
})

vim.api.nvim_set_keymap("n", "gp", "", {
	silent = true,
	callback = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    if ft ~= "idl" then return end
		vim.schedule(function()
			feedkeys(":silent! /\\/\\*\\*\\_.\\{-}\\*\\/<CR>")
			feedkeys("vi{")
			feedkeys(":s//<CR>")
			feedkeys("vi{")
			feedkeys(":s/\\n\\n\\+/\\r/<CR>")
			feedkeys("vi{")
			feedkeys(":s/  \\+/ /<CR>")
			feedkeys("vi{")
			feedkeys(":s/\\_s\\n//<CR>")
			feedkeys(":silent! noh<CR>")
		end)
	end,
})

vim.api.nvim_set_keymap("n", "gj", "", {
	silent = true,
	callback = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    if ft ~= "idl" then return end
		vim.schedule(function()
			vim.api.nvim_feedkeys("vi(J", "n", false)
		end)
	end,
})
