-- reload user modules on save
local reload_hook = require("lvim.config").reload
require("lvim.config").reload = function(self)
	reload_hook(self)

	for module, _ in pairs(package.loaded) do
		if module:match("^user%.") then
			package.loaded[module] = nil
		end
	end
end

-- everforest
vim.g.everforest_background = "medium"
vim.g.everforest_enable_italic = 0
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_show_eob = 0
vim.g.everforest_better_performance = 1

-- ranger
vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_hide_gitignore = 1
vim.g.rnvimr_enable_bw = 1
vim.g.rnvimr_draw_border = 0
vim.g.rnvimr_layout = {
	relative = "editor",
	width = math.floor(0.7 * vim.o.columns),
	height = math.floor(0.7 * vim.o.lines),
	col = math.floor(0.15 * vim.o.columns),
	row = math.floor(0.15 * vim.o.lines),
	style = "minimal",
	border = "single",
}

-- filetype.nvim
vim.g.did_load_filetypes = 1

-- nvim_tree old settings
vim.g.nvim_tree_respect_buf_cwd = 1

-- general
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamed"
vim.opt.fillchars = "vert:▕"
vim.opt.cmdheight = 1
vim.opt.confirm = true
vim.opt.mouse = "nicr"
vim.opt.autoread = true
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "everforest"

require("user.keymap")

-- Notify
lvim.builtin.notify.active = true

-- Autopairs
lvim.builtin.autopairs.active = false

-- project.nvim
lvim.builtin.project.active = true
lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns = { "*.csproj", "*.sln", "package.json", "Makefile", ".git" }

-- Telescope
require("user.telescope").config()

-- CMP
lvim.builtin.cmp.confirm_opts.select = false
lvim.builtin.cmp.completion.completeopt = "menu,menuone,noselect,preview"
lvim.builtin.cmp.preselect = require("cmp").PreselectMode.None
lvim.builtin.cmp.sources = {
	{ name = "nvim_lsp" },
	-- { name = "cmp_tabnine", max_item_count = 3 },
	{ name = "path", max_item_count = 5 },
	{ name = "luasnip", max_item_count = 3 },
	{ name = "buffer", max_item_count = 5, keyword_length = 5 },
	{ name = "nvim_lua" },
	-- { name = "calc" },
	-- { name = "emoji" },
	-- { name = "treesitter" },
	{ name = "crates" },
}

-- Dashboard (or not)
lvim.builtin.dashboard.active = false

-- Terminal
lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.open_mapping = nil
lvim.builtin.terminal.execs = {}
lvim.builtin.terminal.shade_terminals = false
lvim.builtin.terminal.on_config_done = function()
	-- toggleterm is loaded lazily so it needs to be reloaded to function
	package.loaded["user.terminal"] = nil
end

-- barbar
lvim.builtin.bufferline.on_config_done = function()
	vim.g.bufferline.exclude_ft = { "dashboard", "alpha" }
end

-- nvimtree
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.icons.folder.default = ""
lvim.builtin.nvimtree.icons.folder.open = ""
lvim.builtin.nvimtree.icons.folder.empty = ""
lvim.builtin.nvimtree.icons.folder.empty_open = ""
lvim.builtin.nvimtree.show_icons.folder_arrows = 0
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.open_on_startup = false
lvim.builtin.nvimtree.setup.update_focused_file = {
	enable = true,
	update_cwd = false,
}
lvim.builtin.nvimtree.setup.filters = {
	dotfiles = true,
}
lvim.builtin.nvimtree.setup.update_to_buf_dir = {
	enable = true,
	auto_open = false,
}

-- TreeSitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.custom_captures = {
  ["typescript.param.impl"] = "typescriptParamImpl",
  ["typescript.object.label"] = "typescriptObjectLabel"
}
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = true
lvim.builtin.treesitter.highlight.disable = {
	"typescript",
	"typescriptreact",
	"sh",
	"css",
	"html",
	"php",
	"javascript",
	"javascriptreact",
}
lvim.builtin.treesitter.indent.disable = {
	"yaml",
	"javascript",
	"lua",
	"cpp",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

-- lualine
lvim.builtin.lualine.options.disabled_filetypes = { "toggleterm", "dashboard", "terminal" }
lvim.builtin.lualine.options.theme = "everforest"
local conditions = require("lvim.core.lualine.conditions")
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_z = {
	{
		function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "🭶🭶", "🭷🭷", "🭸🭸", "🭹🭹", "🭺🭺", "🭻🭻" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		padding = { left = 0, right = 0 },
		color = { fg = "#dbbc7f", bg = "#323d43" },
		cond = nil,
	},
}
lvim.builtin.lualine.inactive_sections.lualine_a = {
	{
		"filename",
		path = 1,
	},
}
lvim.builtin.lualine.sections.lualine_x = {
	{
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = { error = " ", warn = " ", info = " ", hint = " " },
		color = {},
		diagnostics_color = {
			error = { fg = "#e67e80" },
			warn = { fg = "#dbbc7f" },
			info = { fg = "#7fbbb3" },
			hint = { fg = "#83c092" },
		},
		cond = conditions.hide_in_width,
	},
	components.filetype,
}

-- LSP setup
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.document_highlight = true
lvim.lsp.code_lens_refresh = false
lvim.lsp.automatic_servers_installation = false
local disable_servers = { "emmet_ls", "tailwindcss" }
vim.list_extend(lvim.lsp.override, disable_servers)

-- Additional Plugins
lvim.plugins = require("user.plugins")

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- treesitter doesn't actually respect per-file disable
	{
		"BufEnter",
		"*.ts,*.tsx",
		"lua local disable=require'nvim-treesitter.configs'.commands.TSBufDisable.run disable('indent')",
	},
	-- don't autocomplete inside of Telescope prompts
	{ "FileType", "TelescopePrompt", "lua require('cmp').setup.buffer { sources = {} }" },
	-- C# has 4-space based indent, not 2
	{ "FileType", "cs", "setl ts=4 sts=4 sw=4" },
	-- Resize popup terminal when vim resizes
	{ "VimResized", "*", "lua require('user.terminal').resize()" },
	-- Reload user config when user sub-dirs are modified
	{ "BufWritePost", require("lvim.bootstrap").config_dir .. "/user/*.lua", "lua require('lvim.config'):reload()" },
}

-- Omnisharp fix
require('lvim.lsp.manager').setup("omnisharp", {
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern '*.csproj'(fname) or util.root_pattern '*.sln'(fname)
  end,
})

require("user.null_lsp")
