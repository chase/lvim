local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
if not status_ok then
	vim.cmd([[ packadd nvim-lsp-ts-utils ]])
	ts_utils = require("nvim-lsp-ts-utils")
end

-- defaults
local opts = {
	on_attach = function(client, bufnr)
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,
			import_all_timeout = 1000, -- ms

			-- parentheses completion
			complete_parens = true,
			signature_help_in_parens = false,

			auto_inlay_hints = false,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})
		ts_utils.setup_client(client)
		require("lvim.lsp").common_on_attach(client, bufnr)
	end,
}

return opts
