return {
	filetypes = {
		-- js
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	settings = {
		scss = {
			validate = false,
		},
		tailwindCSS = {
			experimental = {
				classRegex = {
					"tw`([^`]*)", -- tw`...`
					'tw="([^"]*)', -- <div tw="..." />
					'tw={"([^"}]*)', -- <div tw={"..."} />
					"tw\\.\\w+`([^`]*)", -- tw.xxx`...`
					"tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`
				},
			},
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
			},
		},
	},
}
