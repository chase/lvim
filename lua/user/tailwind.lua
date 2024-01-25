local M = {}

function M.setup()
	local opts = {
		root_dir = function(fname)
			local util = require("lspconfig.util")
			return util.root_pattern(
				"tailwind.config.js",
				"tailwind.config.mjs",
				"tailwind.config.cjs",
				"tailwind.config.js",
				"tailwind.config.ts"
			)(fname)
		end,
		filetypes = {
			"html",
			"astro",
			"astro-markdown",
			"markdown",
			"mdx",
			"css",
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
		},
	}

	require("lvim.lsp.manager").setup("tailwindcss", opts)
end

return M
