local M = {}

M.config = function ()
  lvim.plugins = {
    {"~/OSS/everforest"},
    {
      "machakann/vim-sandwich",
      event = "BufRead",
      config = function ()
        vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
      end
    },
    {"knubie/vim-kitty-navigator"},
    {
      "~/OSS/nvim-colorizer.lua",
      ft = {"typescriptreact", "typescript", "javascriptreact", "javascript", "css", "scss", "lua", "html", "vim", "xml"},
    },
    {
      "kosayoda/nvim-lightbulb",
      event = "BufRead",
      config = function()
        vim.fn.sign_define("LightBulbSign", {text=" ", texthl = "YellowSign"})
        vim.cmd [[
        autocmd CursorHold,CursorHoldI * lua if #vim.lsp.buf_get_clients() > 1 then require'nvim-lightbulb'.update_lightbulb() end
        ]]
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "BufRead",
      config = function()
        local cfg = {
          bind = true,
          doc_lines = 0,
          floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
          floating_window_above_cur_line = true,
          fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
          hint_enable = false, -- virtual hint enable
          hint_prefix = "  ", -- Panda for parameter
          hint_scheme = "String",
          -- use_lspsaga = false, -- set to true if you want to use lspsaga popup
          hi_parameter = "Search", -- how your parameter will be highlight
          max_height = 5, -- max height of signature floating_window, if content is more than max_height, you can scroll down
          -- to view the hiding contents
          max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
          handler_opts = {
            border = "rounded",   -- double, single, shadow, none
          },
          extra_trigger_chars = {"(", ",", "{"}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
          zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
          debug = false, -- set to true to enable debug logging
          log_path = "debug_log_file_path", -- debug log path
          padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
          timer_interval = 100,
        }
        require "lsp_signature".setup(cfg)
      end
    },
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
    {
      "folke/lua-dev.nvim",
      before = "williamboman/nvim-lsp-installer",
      ft = "lua"
    },
    {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      ft = {"typescript", "typescriptreact"}
    },
    { 'junegunn/fzf', run = './install --bin', },
    { "kevinhwang91/rnvimr" },
    { '~/OSS/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons'
    }, -- optional for icons
    config = function()
      require('fzf-lua').setup {
        winopts = {
          width = 0.9,
          preview = {
            default = 'builtin',
            horizontal = 'right:40%',
          },
          hl = {
            border = 'FloatBorder',
            preview_border = 'FloatBorder'
          },
          on_create = function ()
            vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", {silent=true, nowait=true})
            vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", {silent=true, nowait=true})
          end
        },
        previewers = {
          builtin = {
            delay = 200,
            syntax = true,
            syntax_limit_l = 0,
          }
        },
        fzf_opts = {
          ['--no-bold'] = ''
        },
        fzf_colors = {
          ["bg"] = { "bg", "NormalFloat" },
          ["preview-bg"] = { "bg", "Normal" },
          ["pointer"] = { "fg", "Blue" },
          ["marker"] = { "fg", "Green" },
          ["fg+"] = { "fg", "CurrentWord" },
          ["bg+"] = { "bg", "CurrentWord" },
          ["gutter"] = { "bg", "NormalFloat" }
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
          }
        },
      }
    end
  },
  {
    "simrat39/symbols-outline.nvim"
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {
        overrides = {
          literal = {
            ["kitty.conf"] = "kitty",
            [".gitignore"] = "conf",
          },
        },
      }
    end,
  },
  {'kevinhwang91/nvim-bqf', ft = 'qf'}
}
end

return M
