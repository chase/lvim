-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
lvim.keys = {
	normal_mode = {
		["<C-s>"] = ":w<cr>",
		["<C-p>"] = function()
			require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
				previewer = false,
				layout_config = { width = 0.8, prompt_position = "top" },
			}))
		end,
		["]e"] = vim.diagnostic.goto_next,
		["[e"] = vim.diagnostic.goto_prev,
		["<F2>"] = vim.lsp.buf.rename,
		["<C-`>"] = function()
			require("user.terminal").toggle()
		end,
		["<C-j>"] = function()
			require("smart-splits").move_cursor_down()
		end,
		["<C-k>"] = function()
			require("smart-splits").move_cursor_up()
		end,
		["<C-h>"] = function()
			require("smart-splits").move_cursor_left()
		end,
		["<C-l>"] = function()
			require("smart-splits").move_cursor_right()
		end,
		["<A-j>"] = function()
			require("smart-splits").resize_down()
		end,
		["<A-k>"] = function()
			require("smart-splits").resize_up()
		end,
		["<A-h>"] = function()
			require("smart-splits").resize_left()
		end,
		["<A-l>"] = function()
			require("smart-splits").resize_right()
		end,
		["]c"] = function()
			require("gitsigns").next_hunk()
		end,
		["[c"] = function()
			require("gitsigns").prev_hunk()
		end,
		["H"] = "<cmd>BufferLineCyclePrev<cr>",
		["L"] = "<cmd>BufferLineCycleNext<cr>",
		["]x"] = "<Plug>(git-conflict-next-conflict)",
		["[x"] = "<Plug>(git-conflict-prev-conflict)",
	},
	visual_mode = {
		["<A-j>"] = false,
		["<A-k>"] = false,
	},
	visual_block_mode = {
		["K"] = false,
		["J"] = false,
		["<A-j>"] = false,
		["<A-k>"] = false,
	},
	term_mode = {
		["<C-`>"] = function()
			require("user.terminal").toggle()
		end,
	},
	insert_mode = {
		["<C-l>"] = "<C-o>$<cmd>silent! LuaSnipUnlinkCurrent<CR>",
		["<C-j>"] = "<C-o>o<cmd>silent! LuaSnipUnlinkCurrent<CR>",
		["<A-j>"] = false,
		["<A-k>"] = false,
		["<S-Tab>"] = "<C-d>",
	},
}

vim.cmd([[ cabbrev <expr> w getcmdtype()==':' && getcmdline() == "'<,'>w" ? '<c-u>w' : 'w' ]])
-- Whichkey
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["z"] = {
	function()
		require("user.zoxide").list()
		vim.schedule(function()
			require("project_nvim.project").on_buf_enter()
		end)
	end,
	"Zoxide",
}
lvim.builtin.which_key.mappings["Z"] = {
	function()
		require("user.zoxide").list(true)
		vim.schedule(function()
			require("project_nvim.project").on_buf_enter()
		end)
	end,
	"Zoxide (Search File)",
}
lvim.builtin.which_key.mappings["v"] = { ":vsplit<cr>", "vsplit" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>RnvimrToggle<cr>", "Explore Files" }
lvim.builtin.which_key.mappings["a"] = lvim.builtin.which_key.mappings.l.a
lvim.builtin.which_key.mappings.g.g = {
	function()
		require("user.terminal").toggle_gitui()
	end,
	"GitUI",
}
lvim.builtin.which_key.mappings["r"] = {
	function()
		require("fzf-lua").oldfiles({ cwd_only = true })
		vim.schedule(function()
			require("project_nvim.project").on_buf_enter()
		end)
	end,
	"Recent Files",
}
lvim.builtin.which_key.mappings.j = lvim.builtin.which_key.mappings.b.j
lvim.builtin.which_key.mappings.s.t = {
	function()
		require("fzf-lua").live_grep_glob({
			resume = true,
		})
	end,
	"Text",
}
lvim.builtin.which_key.mappings.l.e = {
	vim.diagnostic.open_float,
	"Line Diagnostics",
}
lvim.builtin.which_key.mappings.g.c = {
	":GitConflictListQf<cr>",
	"Git Conflict List",
}
lvim.builtin.which_key.mappings["gh"] = {
	function()
		require("lsp_signature").toggle_float_win()
	end,
	"Show/hide signature help",
}
lvim.builtin.which_key.mappings["c"] = { ":BufferKill<cr>", "Close Buffer" }
lvim.builtin.which_key.mappings["q"] = { ":q<cr>", "Quit" }
lvim.builtin.which_key.mappings["o"] = { ":SymbolsOutline<cr>", "Symbols Outline" }
lvim.builtin.which_key.mappings.t = {
	name = "TypeScript",
	o = { ":TSLspOrganize<cr>", "Organize Imports" },
	i = { ":TSLspImportAll<cr>", "Import All" },
	r = { ":TSLspRenameFile<cr>", "Rename File" },
}
lvim.builtin.which_key.mappings.p = { ":ProjectRoot<cr>", "Switch to Project Root" }
-- Exclude bad extensions from being listed in fzf-lua for files
local bad_ext = {
	"svg",
	"pdb",
	"dll",
	"class",
	"exe",
	"jpg",
	"png",
	"cache",
	"ico",
	"pdf",
	"dylib",
	"jar",
	"docx",
	"met",
	"lock",
}
---@diagnostic disable-next-line: cast-local-type
bad_ext = [[ -E '*.]] .. table.concat(bad_ext, [[' -E '*.]]) .. [[']]
lvim.builtin.which_key.mappings.s.f = {
	[[<cmd>lua require('fzf-lua').files({fd_opts = "--type f -E node_modules -E .git]] .. bad_ext .. [["})<cr>]],
	"Files",
}
