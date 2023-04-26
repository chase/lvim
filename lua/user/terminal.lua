local _, toggle_term = pcall(require, "toggleterm.terminal")
if not toggle_term then
	return
end

local Terminal = toggle_term.Terminal

local M = {}

-- current dir to term
local terms = {}

local function make_toggle_term(cwd)
	return Terminal:new({
    cmd = "bash --login",
		direction = "float",
		dir = cwd,
		float_opts = {
			width = function()
				return vim.o.columns
			end,
			height = function(_term)
				local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines / 20)))
				_term.float_opts.row = vim.o.lines - height
				return height
			end,
			border = { "─", "─", "─", " ", "─", "─", "─", " " },
			highlights = {
				-- background = "NormalFloat",
				border = "SpecialComment",
			},
			winblend = 7,
		},
		close_on_exit = true,
	})
end

function M.resize()
	for _, term in pairs(terms) do
		if term:is_open() then
			term:toggle():toggle()
		end
	end
end

function M.toggle()
	local cwd = vim.fn.getcwd()
	local term = terms[cwd]
	if not term then
		term = make_toggle_term(cwd)
		terms[cwd] = term
	end
	term:toggle()
end

local gitui

function M.toggle_gitui()
	if not gitui then
		gitui = Terminal:new({
			cmd = "gitui",
			direction = "float",
			float_opts = {
				width = function()
					return vim.o.columns
				end,
				height = function(_term)
					local height = vim.o.lines - 5
					_term.float_opts.row = 2
					return height
				end,
				border = { "─", "─", "─", " ", "─", "─", "─", " " },
				highlights = {
					background = "NormalFloat",
					border = "FloatBorder",
				},
			},
			close_on_exit = true,
		})
	end

	gitui:toggle()
end

return M
