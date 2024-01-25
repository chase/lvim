local opts = {}
local clangd_flags = {
  "--background-index=0",
  "--fallback-style=google",
  "-j=2",
  "--all-scopes-completion",
  "--pch-storage=disk",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--query-driver=/usr/bin/clang-*,/usr/bin/g++-11"
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  -- require("clangd_extensions.inlay_hints").setup_autocmd()
  -- require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
  clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
  require("lvim.lsp").common_on_init(client, bufnr)
  require("clangd_extensions.config").setup {}
end

opts = {
  cmd = { provider, unpack(clangd_flags) },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern(".gn", "compile_commands.json", ".clangd", ".git")(fname)
  end,
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  filetypes = {
    "cpp", "cxx", "cc", "c", "hxx", "h"
  }
}

require("lvim.lsp.manager").setup("clangd", opts)
