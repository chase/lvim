-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
lvim.keys = {
	normal_mode = {
		["<C-s>"] = ":w<cr>",
		["<C-/>"] = '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
		["<C-p>"] = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false, layout_config={width=0.8,prompt_position='top'}}))<cr>",
		["]e"] = "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
		["[e"] = "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
		["<F2>"] = "<cmd>lua vim.lsp.buf.rename()<cr>",
		["<C-`>"] = "<cmd>lua require('user.terminal').toggle()<cr>",
		["<A-j>"] = false,
		["<A-k>"] = false,
		["]c"] = "<cmd>lua require'gitsigns'.next_hunk()<cr>",
		["[c"] = "<cmd>lua require'gitsigns'.prev_hunk()<cr>",
	},
	visual_mode = {
		["<C-/>"] = "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
		["<A-j>"] = false,
		["<A-k>"] = false,
	},
	visual_block_mode = {
		["K"] = false,
		["J"] = false,
		["<A-j>"] = false,
		["<A-k>"] = false,
	},
	term_mode = { ["<C-`>"] = "<cmd>lua require('user.terminal').toggle()<cr>" },
	insert_mode = {
		["<C-l>"] = "<C-o>$<cmd>silent! LuaSnipUnlinkCurrent<CR>",
		["<C-j>"] = "<C-o>o<cmd>silent! LuaSnipUnlinkCurrent<CR>",
		["<A-j>"] = false,
		["<A-k>"] = false,
	},
}

vim.cmd([[ cabbrev <expr> w getcmdtype()==':' && getcmdline() == "'<,'>w" ? '<c-u>w' : 'w' ]])
-- Whichkey
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["z"] = { "<cmd>lua require('user.zoxide').list()<cr>", "Zoxide" }
lvim.builtin.which_key.mappings["Z"] = { "<cmd>lua require('user.zoxide').list(true)<cr>", "Zoxide (Open Ranger)" }
lvim.builtin.which_key.mappings["v"] = { ":vsplit<cr>", "vsplit" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>RnvimrToggle<cr>", "Explore Files" }
lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('user.telescope').lsp_code_actions()<cr>", "Code Actions" }
lvim.builtin.which_key.mappings.g.g = { "<cmd>lua require('user.terminal').toggle_gitui()<cr>", "GitUI" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>lua require('fzf-lua').oldfiles({cwd_only=true})<CR>", "Recent Files" }
lvim.builtin.which_key.mappings.j = lvim.builtin.which_key.mappings.b.j
lvim.builtin.which_key.mappings.s.t = { "<cmd>lua require('fzf-lua').live_grep_native()<cr>", "Text" }
lvim.builtin.which_key.mappings.l.e = {
	"<cmd>lua require('lvim.lsp.handlers').show_line_diagnostics()<cr>",
	"Line Diagnostics",
}
lvim.builtin.which_key.mappings["gh"] = {
	"<cmd>cmd>lua require('lsp_signature').toggle_float_win()<cr>",
	"Show/hide signature help",
}
lvim.builtin.which_key.mappings["c"] = { ":BufferClose<cr>", "Close Buffer" }
lvim.builtin.which_key.mappings["q"] = { ":q<cr>", "Quit" }
lvim.builtin.which_key.mappings["o"] = { ":SymbolsOutline<cr>", "Symbols Outline" }
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
bad_ext = [[ -E '*.]] .. table.concat(bad_ext, [[' -E '*.]]) .. [[']]
lvim.builtin.which_key.mappings.s.f = {
	[[<cmd>lua require('fzf-lua').files({fd_opts = "--type f -E node_modules -E .git]] .. bad_ext .. [["})<cr>]],
	"Text",
}

