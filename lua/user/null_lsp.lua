---@diagnostic disable: redundant-parameter
local nls_ok, nls = pcall(require, "null-ls")
if nls_ok then
	nls.setup({
		debounce = 150,
		save_after_format = false,
		sources = {
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
			nls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({ ".eslintrc", ".eslintrc.json" })
        end,
      }),
			nls.builtins.code_actions.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({ ".eslintrc", ".eslintrc.json" })
        end,
      }),
			nls.builtins.formatting.prettierd,
			nls.builtins.diagnostics.vint,
		},
	})
end
