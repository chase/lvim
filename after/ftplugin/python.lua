local opts = {
  root_dir = function(fname)
    local util = require "lspconfig.util"
    -- way too aggressive if setting to git root
    return util.path.dirname(fname)
  end,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
}

require("lvim.lsp.manager").setup("pyright", opts)
