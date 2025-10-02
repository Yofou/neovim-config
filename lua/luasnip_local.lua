local cwd = vim.loop.cwd()
local vscodeFolder = string.gsub(cwd .. "/.vscode", "/home/yofou", "~")

require("luasnip.loaders.from_vscode").lazy_load({
		paths = "~/.config/nvim/snippets"
})

require("luasnip.loaders.from_vscode").lazy_load({
		paths = vscodeFolder
})

print(vscodeFolder)
