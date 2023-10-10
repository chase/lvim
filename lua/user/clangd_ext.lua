local M = {}

M.config = function()
	local capabilities = require("lvim.lsp").common_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
  capabilities.semanticTokensProvider = false

	local clangd_flags = {
		"--fallback-style=google",
		"--background-index",
		"-j=16",
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
		"--folding-ranges",
    "--query-driver=/usr/bin/g++-11,/usr/bin/clang-*"
	}

	require("clangd_extensions").setup({
		server = {
			root_dir = function(fname)
				local util = require("lspconfig.util")
				return util.root_pattern("compile_commands.json", ".git")(fname)
			end,
			cmd = { "clangd", unpack(clangd_flags) },
			capabilities = capabilities,
			on_attach = require("lvim.lsp").common_on_attach,
			on_init = require("lvim.lsp").common_on_init,
		},
		extensions = {
			autoSetHints = false,
			inlay_hints = {
				parameter_hints_prefix = "",
				other_hints_prefix = "",
			},
		},
	})
end
return M
