local lspconfig = require('lspconfig')
local configs = require("lspconfig.configs")

local server_name = "astro-ls"
configs[server_name] = {
	default_config = {
		filetypes = { "astro" },
		cmd = { "astro-ls", "--stdio" },
		root_dir = lspconfig.util.root_pattern("package.json", ".git"),
		init_options = {
			configuration = {
				astro = {},
				prettier = {},
				emmet = {},
				typescript = {},
				javascript = {},
			},
			environment = "node",
			dontFilterIncompleteCompletions = true,
			isTrusted = true,
		}
	}
}

lspconfig[server_name].setup {}
