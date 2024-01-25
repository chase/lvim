-- reload user modules on save
for module, _ in pairs(package.loaded) do
	if module:match("^user%.") or module:match("^icons.lua") then
		package.loaded[module] = nil
	end
end

-- everforest
vim.g.everforest_background = "hard"
vim.g.everforest_sign_column_background = "grey"
vim.g.everforest_enable_italic = 0
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_show_eob = 0
vim.g.everforest_ui_contrast = "low"
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

local disabled_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}
for _, plugin in pairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- general
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamed"
vim.opt.fillchars = "vert:▕,verthoriz:🮀,horiz:🮀,horizdown:🮀,horizup:🮀,vertleft:▕,vertright:▕"
vim.opt.cmdheight = 1
vim.opt.confirm = true
vim.opt.mouse = "nicr"
vim.opt.autoread = true
vim.opt.pumblend = 10
pcall(vim.api.nvim_del_augroup_by_name, "_format_options")
vim.opt.formatoptions = {
	["1"] = false,
	["2"] = false, -- Use indent from 2nd line of a paragraph
	q = true, -- continue comments with gq"
	c = false, -- Auto-wrap comments using textwidth
	r = false, -- Continue comments when pressing Enter
	o = false, -- same as above but on O/o
	n = true, -- Recognize numbered lists
	t = false, -- autowrap lines using text width value
	j = true, -- remove a comment leader when joining lines.
	-- Only break if the line was not longer than 'textwidth' when the insert
	-- started and only at a white character that has been entered during the
	-- current insert command.
	l = true,
	v = true,
}
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "everforest"

require("user.keymap")

-- Indentlines
lvim.builtin.indentlines.active = false
require('user.indent_blankline').setup()

-- Autopairs
lvim.builtin.autopairs.active = true
lvim.builtin.autopairs.enable_check_bracket_line = true

-- project.nvim
lvim.builtin.project.active = true
lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns =
	{ "compile_commands.json", "*.csproj", "*.sln", "package.json", "Makefile", "CMakeLists.txt", ".git" }
lvim.builtin.project.manual_mode = true

-- Telescope
require("user.telescope").config()

-- CMP
local cmp = require("cmp")
lvim.builtin.cmp.confirm_opts.select = false
-- lvim.builtin.cmp.window.documentation
lvim.builtin.cmp.completion.completeopt = "menu,menuone,noselect,preview"
lvim.builtin.cmp.preselect = cmp.PreselectMode.None
lvim.builtin.cmp.sources = {
	{
		name = "nvim_lsp",
		entry_filter = function(entry, ctx)
			local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
			if kind == "Snippet" and ctx.prev_context.filetype == "java" then
				return false
			end
			if kind == "Text" then
				return true
			end
			if kind == "Keyword" then
				return false
			end
			return true
		end,
	},
	-- { name = "cmp_tabnine", max_item_count = 3 },
	{ name = "path", max_item_count = 5 },
	{ name = "luasnip", max_item_count = 3 },
	{ name = "buffer", max_item_count = 5, keyword_length = 5 },
	-- { name = "nvim_lua" },
	-- { name = "calc" },
	-- { name = "emoji" },
	-- { name = "treesitter" },
	{ name = "crates" },
}
-- lvim.builtin.cmp.sorting = {
-- 	comparators = {
-- 		cmp.config.compare.recently_used,
-- 		cmp.config.compare.score,
-- 		cmp.config.compare.locality,
-- 		cmp.config.compare.offset,
-- 		cmp.config.compare.exact,
-- 		cmp.config.compare.scopes,
-- 		cmp.config.compare.kind,
-- 		cmp.config.compare.sort_text,
-- 		cmp.config.compare.length,
-- 		cmp.config.compare.order,
-- 	},
-- }
-- lvim.builtin.cmp.formatting.max_width = 120
-- lvim.builtin.cmp.formatting.fields = { "kind", "abbr", "menu" }
-- if vim.tbl_contains({ "cpp", "c", "objcpp", "objc" }, vim.bo.filetype) then
-- 	table.insert(lvim.builtin.cmp.sorting.comparators, 3, require("clangd_extensions.cmp_scores"))
-- end
lvim.builtin.cmp.performance = {
	debounce = 10,
	throttle = 40,
	fetching_timeout = 100,
	async_budget = 1,
	max_view_entires = 20,
}
-- Dashboard (or not)
lvim.builtin.alpha.active = false

-- Terminal
lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.open_mapping = nil
lvim.builtin.terminal.execs = {}
lvim.builtin.terminal.shade_terminals = false
lvim.builtin.terminal.on_config_done = function()
	-- toggleterm is loaded lazily so it needs to be reloaded to function
	package.loaded["user.terminal"] = nil
end

-- bufferline
lvim.builtin.bufferline.options.always_show_bufferline = true
local no_italics = {
	"background",
	"buffer_selected",
	"numbers_selected",
	"error_selected",
	"error_selected",
	"error_diagnostic_selected",
	"duplicate_selected",
	"duplicate",
	"duplicate_visible",
	"diagnostic_selected",
	"hint_selected",
	"hint_diagnostic_selected",
	"info_selected",
	"info_diagnostic_selected",
	"warning_selected",
	"warning_diagnostic_selected",
	"pick_selected",
	"pick_visible",
	"pick",
}
for _, hl in ipairs(no_italics) do
	lvim.builtin.bufferline.highlights[hl] = { italic = false }
end
lvim.builtin.bufferline.options.show_tab_indicators = false

local icons = lvim.icons.kind
lvim.builtin.breadcrumbs.active = true
-- lvim.builtin.breadcrumbs.options.separator = "〉"
lvim.builtin.breadcrumbs.options.icons = {
	Array = icons.Array .. " ",
	-- Boolean = icons.Boolean .. " ",
	Class = icons.Class .. " ",
	Color = icons.Color .. " ",
	Constant = icons.Constant .. " ",
	Constructor = icons.Constructor .. " ",
	Enum = icons.Enum .. " ",
	EnumMember = icons.EnumMember .. " ",
	Event = icons.Event .. " ",
	Field = icons.Field .. " ",
	File = icons.File .. " ",
	Folder = icons.Folder .. " ",
	Function = icons.Function .. " ",
	Interface = icons.Interface .. " ",
	Key = icons.Key .. " ",
	Keyword = icons.Keyword .. " ",
	Method = icons.Method .. " ",
	Module = icons.Module .. " ",
	Namespace = icons.Namespace .. " ",
	Null = icons.Null .. " ",
	Number = icons.Number .. " ",
	Object = icons.Object .. " ",
	Operator = icons.Operator .. " ",
	Package = icons.Package .. " ",
	Property = icons.Property .. " ",
	Reference = icons.Reference .. " ",
	Snippet = icons.Snippet .. " ",
	String = icons.String .. " ",
	Struct = icons.Struct .. " ",
	Text = icons.Text .. " ",
	TypeParameter = icons.TypeParameter .. " ",
	-- Unit = icons.Unit .. " ",
	-- Value = icons.Value .. " ",
	Variable = icons.Variable .. " ",
}

-- nvimtree
-- lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.folder_arrow = false
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.default = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.open = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.empty = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.empty_open = ""
lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.git.ignore = true
lvim.builtin.nvimtree.setup.filesystem_watchers.ignore_dirs = {
	"node_modules",
	".git",
	".cache",
	"translations",
}
-- lvim.builtin.nvimtree.setup.open_on_startup = false
lvim.builtin.nvimtree.setup.update_focused_file = {
	enable = false,
	update_root = false,
}
lvim.builtin.nvimtree.setup.filters = {
	dotfiles = true,
	exclude = { ".gitignore", ".github", ".env" },
}

-- TreeSitter
lvim.builtin.treesitter.ignore_install = { "haskell" }
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
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

lvim.builtin.gitsigns.opts.signs.untracked = { text = lvim.builtin.gitsigns.opts.signs.add.text }

-- lualine
lvim.builtin.lualine.options.disabled_filetypes = { "toggleterm", "dashboard", "terminal" }
lvim.builtin.lualine.options.theme = "everforest"
local conditions = require("lvim.core.lualine.conditions")
local components = require("lvim.core.lualine.components")
components.mode[1] = function()
	return " "
end
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
lvim.builtin.lualine.sections.lualine_c = {
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
-- lvim.lsp.diagnostics.virtual_text = false
vim.diagnostic.config({ virtual_text = false })
lvim.lsp.document_highlight = false
lvim.lsp.code_lens_refresh = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
	"tailwindcss",
}
lvim.lsp.automatic_configuration.skipped_servers = vim.list_extend(
	lvim.lsp.automatic_configuration.skipped_servers,
	{ "cssls", "tailwindcss", "emmet_ls", "angular-language-server", "clangd", "pyright", "omnisharp" }
)

-- Additional Plugins
lvim.plugins = require("user.plugins")

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
local autocmds = {
	-- treesitter doesn't actually respect per-file disable
	{
		"BufEnter",
		{ "*.ts", "*.tsx" },
		function()
			local disable = require("nvim-treesitter.configs").commands.TSBufDisable.run
			disable("indent")
		end,
	},
	-- don't autocomplete inside of Telescope prompts
	{
		"FileType",
		"TelescopePrompt",
		function()
			require("cmp").setup.buffer({ sources = {} })
		end,
	},
	-- C# has 4-space based indent, not 2
	{
		"FileType",
		"cs",
		function()
			vim.cmd("setl ts=4 sts=4 sw=4")
		end,
	},
	-- Resize popup terminal when vim resizes
	{ "VimResized", "*", require("user.terminal").resize },
	-- Reload user config when user sub-dirs are modified
	{
		"BufWritePost",
		require("lvim.bootstrap").config_dir .. "/lua/user/*.lua",
		function()
			require("lvim.config"):reload()
		end,
	},
	{
		"BufEnter",
		"*",
    function()
			vim.opt.formatoptions = {
				["1"] = false,
				["2"] = false, -- Use indent from 2nd line of a paragraph
				q = true, -- continue comments with gq"
				c = false, -- Auto-wrap comments using textwidth
				r = false, -- Continue comments when pressing Enter
				o = false, -- same as above but on O/o
				n = true, -- Recognize numbered lists
				t = false, -- autowrap lines using text width value
				j = true, -- remove a comment leader when joining lines.
				-- Only break if the line was not longer than 'textwidth' when the insert
				-- started and only at a white character that has been entered during the
				-- current insert command.
				l = true,
				v = true,
			}
    end
	},
	{
		"FileType",
		{ "cpp", "c", "objc", "objcpp" },
		function()
			vim.cmd("nmap <M-o> <cmd>ClangdSwitchSourceHeader<cr>")
		end,
	},
	{
		"FileType",
		{ "cpp", "c", "objc", "objcpp" },
		function()
			vim.opt.formatoptions = {
				["1"] = false,
				["2"] = false, -- Use indent from 2nd line of a paragraph
				q = true, -- continue comments with gq"
				c = false, -- Auto-wrap comments using textwidth
				r = false, -- Continue comments when pressing Enter
				o = false, -- same as above but on O/o
				n = true, -- Recognize numbered lists
				t = false, -- autowrap lines using text width value
				j = true, -- remove a comment leader when joining lines.
				-- Only break if the line was not longer than 'textwidth' when the insert
				-- started and only at a white character that has been entered during the
				-- current insert command.
				l = true,
				v = true,
			}
			-- vim.cmd("nmap <M-o> <cmd>ClangdSwitchSourceHeader<cr>")
		end,
	},
}
for _, value in pairs(autocmds) do
	vim.api.nvim_create_autocmd(value[1], {
		pattern = value[2],
		callback = value[3],
	})
end

-- Omnisharp fix
require("lvim.lsp.manager").setup("omnisharp", {
	root_dir = function(fname)
		local util = require("lspconfig.util")
		return util.root_pattern("*.csproj", "*.sln")(fname)
	end,
})

require("user.null_lsp")
