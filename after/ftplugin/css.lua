-- todo: figure out a good way to only ignore in Tailwind projects, or load css_tailwind_customData.json
local opts = {
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
}

require("lvim.lsp.manager").setup("cssls", opts)
require("user.tailwind").setup()
