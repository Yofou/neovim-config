require('commented').setup({
	keybindings = {
		v = "/"
	},
	prefer_block_comment = true,
	block_cms = {
		typescriptreact = { block = "{/* %s */}" }
	},
	set_keybindings = true
})
