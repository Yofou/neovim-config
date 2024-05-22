require('commented').setup({
	keybindings = {
		v = "/"
	},
	prefer_block_comment = true,
	block_cms = {
		typescriptreact = { block = "{/* %s */}" }
	},
	set_keybindings = true,
	hooks = {
        before_comment = require("ts_context_commentstring.internal").update_commentstring,
    },
})

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    'astro', 'css', 'glimmer', 'graphql', 'html', 'javascript',
	'lua', 'php', 'python', 'scss', 'svelte', 'tsx', 'twig',
	'typescript', 'vim', 'vue',
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  languages = {
    typescript = '// %s',
  },
}
