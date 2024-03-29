return {
	{ name = "everforest", dir = "~/OSS/everforest" },
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{ "mrjones2014/smart-splits.nvim", build = "./kitty/install-kittens.bash" },
	{
		name = "nvim-colorizer",
		dir = "~/OSS/nvim-colorizer.lua",
		ft = {
			"typescriptreact",
			"typescript",
			"javascriptreact",
			"javascript",
			"css",
			"scss",
			"lua",
			"html",
			"vim",
			"xml",
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "BufRead",
		config = function()
			vim.cmd([[
      autocmd CursorHold,CursorHoldI * lua if #vim.lsp.buf_get_clients() > 1 then require'nvim-lightbulb'.update_lightbulb() end
      ]])
			require("nvim-lightbulb").setup({
				sign = {
					text = "",
					hl = "YellowSign",
				},
			})
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		local cfg = {
	-- 			bind = true,
	-- 			doc_lines = 0,
	-- 			floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
	-- 			floating_window_above_cur_line = true,
	-- 			fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	-- 			hint_enable = true, -- virtual hint enable
	-- 			hint_prefix = "  ", -- Panda for parameter
	-- 			hint_scheme = "String",
	-- 			-- use_lspsaga = false, -- set to true if you want to use lspsaga popup
	-- 			hi_parameter = "Search", -- how your parameter will be highlight
	-- 			max_height = 5, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- 			-- to view the hiding contents
	-- 			max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	-- 			handler_opts = {
	-- 				border = "rounded", -- double, single, shadow, none
	-- 			},
	-- 			extra_trigger_chars = { "(", ",", "{" }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	-- 			zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
	-- 			debug = false, -- set to true to enable debug logging
	-- 			log_path = "debug_log_file_path", -- debug log path
	-- 			padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
	-- 			timer_interval = 100,
	-- 			close_timeout = 1000,
	-- 			shadow_blend = 36,
	-- 			shadow_guibg = "#2b3339",
	-- 			transparency = 15,
	-- 		}
	-- 		require("lsp_signature").setup(cfg)
	-- 	end,
	-- },
	-- {
	--   "folke/trouble.nvim",
	--   event = "BufRead",
	--   requires = "kyazdani42/nvim-web-devicons",
	--   config = function()
	--     require("trouble").setup {
	--       -- your configuration comes here
	--       -- or leave it empty to use the default settings
	--       -- refer to the configuration section below
	--     }
	--   end
	-- },
	-- {
	--   "folke/lua-dev.nvim",
	--   before = "williamboman/nvim-lsp-installer",
	--   ft = "lua"
	-- },
	{
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		ft = { "typescript", "typescriptreact" },
	},
	{ "junegunn/fzf", build = "./install --bin" },
	-- { "kevinhwang91/rnvimr" },
	{
		name = "fzf-lua",
		dir = "~/OSS/fzf-lua",
		dependencies = {
			"vijaymarupudi/nvim-fzf",
			-- "kyazdani42/nvim-web-devicons",
		}, -- optional for icons
		config = function()
			require("fzf-lua").setup({
				winopts = {
					width = 0.9,
					preview = {
						default = "builtin",
						horizontal = "right:40%",
					},
					hl = {
						border = "FloatBorder",
						preview_border = "FloatBorder",
					},
					on_create = function()
						vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", { silent = true, nowait = true })
						vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", { silent = true, nowait = true })
					end,
				},
				previewers = {
					builtin = {
						delay = 200,
						syntax = true,
						syntax_limit_l = 0,
					},
				},
				fzf_opts = {
					["--no-bold"] = "",
				},
				fzf_colors = {
					["bg"] = { "bg", "NormalFloat" },
					["preview-bg"] = { "bg", "Normal" },
					["pointer"] = { "fg", "Blue" },
					["marker"] = { "fg", "Green" },
					["fg+"] = { "fg", "CurrentWord" },
					["bg+"] = { "bg", "CurrentWord" },
					["gutter"] = { "bg", "NormalFloat" },
				},
				keymap = {
					fzf = {
						["tab"] = "down",
						["shift-tab"] = "up",
						["esc"] = "abort",
						["ctrl-z"] = "abort",
						["ctrl-u"] = "unix-line-discard",
						["ctrl-f"] = "half-page-down",
						["ctrl-b"] = "half-page-up",
						["ctrl-a"] = "beginning-of-line",
						["ctrl-e"] = "end-of-line",
						["alt-a"] = "toggle-all",
					},
				},
			})
		end,
	},
	-- { "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"stevearc/dressing.nvim",
		dir = "~/OSS/dressing.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("user.dressing").config()
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		config = function()
			-- require("telescope._extensions.zoxide.config").setup({
			--   prompt_title
			-- })
		end,
	},
	{ "jvirtanen/vim-hcl" },
	-- { "nvim-treesitter/playground" },
	-- {
	-- 	ft = { "c", "cpp", "objc", "objcpp" },
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	"Badhi/nvim-treesitter-cpp-tools",
	--    config = function()
	--      require('nt-cpp-tools').setup({
	--        source_extensions = 'cc'
	--      })
	--    end
	-- },
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
	},
	{ "folke/zen-mode.nvim" },
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
			})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },
	-- {
	-- 	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 		vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
	-- 	end,
	-- },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "co",
					theirs = "ct",
					both = "cb",
					none = "c0",
					next = "]x",
					prev = "[x",
				},
				highlights = {
					incoming = nil,
					current = nil,
				},
			})
		end,
	},
	{
		url = "https://github.com/yorickpeterse/nvim-pqf",
		config = true,
	},
	{
		"simrat39/rust-tools.nvim",
		lazy = true,
		config = function()
			require("user.rust_tools").config()
		end,
		ft = { "rust", "rs" },
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = true,
	},
	{
		name = "ts-cpp-tools",
		dir = "~/OSS/nvim-treesitter-cpp-tools",
		ft = {
			"cpp",
		},
		opts = {
			preview = {
				quit = "<esc>",
				accept = "<cr>",
			},
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		name = "gn-vim",
		dir = "~/OSS/gn-vim",
	},
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   name = "new-indent",
  --   main = "ibl",
  --   -- enabled = ~vim.builtin.indentlines.active,
  -- },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function ()
      require("user.hlchunk").setup()
    end
  }
}
