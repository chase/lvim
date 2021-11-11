-- everforest --
vim.g.everforest_background = 'medium'
vim.g.everforest_enable_italic = 0
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_diagnostic_virtual_text = 'colored'
vim.g.everforest_show_eob = 0
vim.g.everforest_better_performance = 1

-- ranger --
vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_hide_gitignore = 1

-- filetype.nvim
vim.g.did_load_filetypes = 1

-- general
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamed"
vim.opt.fillchars = "vert:▕"
vim.opt.cmdheight = 1
vim.opt.confirm = true
vim.opt.mouse = "nicr"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "everforest"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
lvim.keys = {
  normal_mode = {
      ["<C-s>"] = ":w<cr>",
      ["<C-/>"] = "<Cmd>lua ___comment_call('gc')<CR>g@g@",
      ["<C-p>"] = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false, layout_config={width=0.8,prompt_position='top'}}))<cr>",
      ["]e"] = "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
      ["[e"] = "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      ["<F2>"] = "<cmd>lua vim.lsp.buf.rename()<cr>",
      ["<C-`>"] = "<cmd>lua _ToggleTerm()<cr>",
      ["<A-j>"] = false,
      ["<A-k>"] = false,
      ["]c"] = "<cmd>lua require'gitsigns'.next_hunk()<cr>",
      ["[c"] = "<cmd>lua require'gitsigns'.prev_hunk()<cr>",
  },
  visual_mode = {
    ["<C-/>"] = "<esc><cmd>lua ___comment_gc(vim.fn.visualmode())<CR>",
    ["<A-j>"] = false,
    ["<A-k>"] = false,
  },
  visual_block_mode = {
    ["K"] = false,
    ["J"] = false,
    ["<A-j>"] = false,
    ["<A-k>"] = false,
  },
  term_mode = {["<C-`>"] = "<cmd>lua _ToggleTerm()<cr>"},
  insert_mode = {
    ["<C-l>"] = "<C-o>$<cmd>silent! LuaSnipUnlinkCurrent<CR>",
    ["<C-j>"] = "<C-o>o<cmd>silent! LuaSnipUnlinkCurrent<CR>",
    ["<A-j>"] = false,
    ["<A-k>"] = false,
  }
}
vim.cmd [[
  cabbrev <expr> w getcmdtype()==':' && getcmdline() == "'<,'>w" ? '<c-u>w' : 'w'
]]
-- Whichkey
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["v"] = {":vsplit<cr>", "vsplit"}
lvim.builtin.which_key.mappings["a"] = {"<cmd>lua require('user.telescope').lsp_code_actions()<cr>", "Code Actions"}
lvim.builtin.which_key.mappings.g.g = {"<cmd>lua _ToggleGitUI()<cr>", "GitUI"}
lvim.builtin.which_key.mappings["r"] = { "<cmd>lua require('fzf-lua').oldfiles({cwd_only=true})<CR>", "Recent Files" }
lvim.builtin.which_key.mappings.j = lvim.builtin.which_key.mappings.b.j
lvim.builtin.which_key.mappings.s.t = { "<cmd>lua require('fzf-lua').live_grep_native()<cr>", "Text" }
lvim.builtin.which_key.mappings.l.e = { "<cmd>lua require('lvim.lsp.handlers').show_line_diagnostics()<cr>", "Line Diagnostics"}
lvim.builtin.which_key.mappings["gs"] = nil
lvim.builtin.which_key.mappings["gh"] = { "<cmd>cmd>lua require('lsp_signature').toggle_float_win()<cr>", "Show/hide signature help" }
lvim.builtin.which_key.mappings["c"] = { ":BufferClose<cr>", "Close Buffer"}
lvim.builtin.which_key.mappings["q"] = { ":q<cr>", "Quit"}
lvim.builtin.which_key.mappings["o"] = { ":SymbolsOutline<cr>", "Symbols Outline"}
-- Exclude bad extensions from being listed in fzf-lua for files
local bad_ext = {
  'svg',
  'pdb',
  'dll',
  'class',
  'exe',
  'jpg',
  'png',
  'cache',
  'ico',
  'pdf',
  'dylib',
  'jar',
  'docx',
  'met'
}
bad_ext = [[ -E '*.]] .. table.concat(bad_ext, [[' -E '*.]]) .. [[']]
lvim.builtin.which_key.mappings.s.f = { [[<cmd>lua require('fzf-lua').files({fd_opts = "--type f -E node_modules -E .git]] .. bad_ext .. [["})<cr>]], "Text" }

lvim.builtin.notify.active = true

-- Autopairs
lvim.builtin.autopairs.active = false

-- project.nvim
lvim.builtin.project.active = true
-- package.json is more important than .git in a monorepo
lvim.builtin.project.detection_methods = { "pattern", "lsp" }
table.insert(lvim.builtin.project.patterns, 1, "package.json")
table.remove(lvim.builtin.project.patterns)

-- Telescope
require('user.telescope').config()

-- CMP
lvim.builtin.cmp.confirm_opts.select = false
lvim.builtin.cmp.completion.completeopt = "menu,menuone,noselect,preview"
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

-- lvim.builtin.dashboard.custom_header = require('headers.moon3')
lvim.builtin.dashboard.active = false

-- Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = nil
lvim.builtin.terminal.execs = {}
lvim.builtin.terminal.shade_terminals = false
lvim.builtin.terminal.on_config_done = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    direction = 'float',
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
        border = "SpecialComment"
      },
      winblend = 7
    },
    close_on_exit = true
  })
  function _ToggleTerm()
    term:toggle()
  end

  local gitui = Terminal:new({
    cmd = 'gitui',
    direction = 'float',
    float_opts = {
      width = function()
        return vim.o.columns
      end,
      border = 'solid',
    },
    close_on_exit = true
  })
  function _ToggleGitUI()
    gitui:toggle()
  end
end

-- barbar
lvim.builtin.bufferline.on_config_done = function()
  vim.g.bufferline.exclude_ft = {'dashboard', 'alpha'}
end

-- nvimtree
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.icons.folder.default = ""
lvim.builtin.nvimtree.icons.folder.open = ""
lvim.builtin.nvimtree.icons.folder.empty = ""
lvim.builtin.nvimtree.icons.folder.empty_open = ""
lvim.builtin.nvimtree.show_icons.folder_arrows = 0
lvim.builtin.nvimtree.hide_dotfiles = false

-- TreeSitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = true
lvim.builtin.treesitter.highlight.disable = {"typescript", "typescriptreact","sh","css", "html", "php", "javascript", "javascriptreact"}
lvim.builtin.treesitter.indent.disable = {"yaml","javascript","lua","cpp","typescript", "javascriptreact", "typescriptreact"}

-- lualine
lvim.builtin.lualine.options.disabled_filetypes = {"toggleterm", "dashboard", "terminal"}
lvim.builtin.lualine.options.theme = "everforest"
local conditions = require "lvim.core.lualine.conditions"
local components = require"lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_z = {
  {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "🭶🭶", "🭷🭷", "🭸🭸", "🭹🭹", "🭺🭺", "🭻🭻"}
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
    path = 1
  }
}
lvim.builtin.lualine.sections.lualine_x = {
  {
    "diagnostics",
    sources = { "nvim_lsp" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    color = {},
    diagnostics_color = {
      error = { fg = '#e67e80' },
      warn = { fg = '#dbbc7f' },
      info = { fg = '#7fbbb3' },
      hint = { fg = '#83c092' },
    },
    cond = conditions.hide_in_width,
  },
  components.filetype
}

-- LSP setup
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.document_highlight = true
lvim.lsp.code_lens_refresh = true
lvim.lsp.automatic_servers_installation = false
local custom_servers = { "sumneko_lua", "tsserver", "jsonls", "html", "tailwindcss" }
local disable_servers = { "emmet_ls" }
vim.list_extend(lvim.lsp.override, disable_servers)
vim.list_extend(lvim.lsp.override, custom_servers)

-- Additional Plugins
require('user.plugins').config()

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
