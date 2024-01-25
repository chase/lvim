local M = {}

M.setup = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end
  ibl.setup {
    indent = {
      -- only show active line
      char = ' ',
    },
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        "alpha",
        "log",
        "gitcommit",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_hover",
        "LuaTree",
        "dbui",
        "UltestSummary",
        "UltestOutput",
        "vimwiki",
        "markdown",
        "json",
        "txt",
        "vista",
        "NvimTree",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "org",
        "orgagenda",
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "Outline",
        "Trouble",
        "lspinfo",
        "", -- for all buffers without a file type
      },
    },
    scope = {
      enabled = true,
      show_start = false,
      highlight = {"LineNr"},
      char = '▏',
      show_exact_scope = true
    },
  }
  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
end

M.enable = function()
  if not lvim.builtin.indentlines.active then
    require("ibl").setup_buffer(0, { enabled = true })
  end
end

M.disable = function()
  if not lvim.builtin.indentlines.active then
    require("ibl").setup_buffer(0, { enabled = false })
  end
end

return M
