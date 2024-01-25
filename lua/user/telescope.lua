local M = {}
local api = vim.api
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"

local function feedkeys(keys)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, false, true), "t", true)
end

function M.config()
  lvim.builtin.telescope.active = true
  -- prompt_prefix introduces bugs when deleting characters
  lvim.builtin.telescope.defaults.prompt_prefix = ""
  lvim.builtin.telescope.defaults.selection_caret = " "
  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.telescope.defaults.layout_config = {
    width = 0.75,
    -- height = 20,
    prompt_position = "bottom",
    preview_cutoff = 120,
    horizontal = { mirror = false },
    vertical = { mirror = false },
  }
  lvim.builtin.telescope.pickers = {
    find_files = {
      find_command = {
        'rg',
        '--type=all',
        '--ignore',
        '--files'
      }
    }
  }
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<Esc>"] = "close",
      ["<C-a>"] = function()
        feedkeys("<C-o>0")
      end,
      ["<C-e>"] = function()
        feedkeys("<C-o>$")
      end,
      ["<C-u>"] = function()
        feedkeys("<C-o>c0")
      end,
    }
  }
  lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    ".git/",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "target/",
    '%.svg',
    '%.pdb',
    '%.dll',
    '%.class',
    '%.exe',
    '%.jpg',
    '%.png',
    '%.cache',
    '%.ico',
    '%.pdf',
    '%.dylib',
    '%.jar',
    '%.docx',
    '%.met',
    'smalljre_*/*',
    "messages.po",
  }
end

function M.find_files()
  local opts = {
    previewer = false,
    layout_config = {
      width=0.8,
      prompt_position='top'
    }
  }
  builtin.find_files(themes.get_dropdown(opts))
end

return M
