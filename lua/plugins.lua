return require("packer").startup(function (use)
    use 'pineapplegiant/spaceduck'
    use 'evanleck/vim-svelte'
    use 'dag/vim-fish'
    use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = "make"} },
		config = function ()
			require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" } } }
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('fzf')
		end
	}
    use 'itchyny/lightline.vim'
    use 'neovim/nvim-lspconfig'
    use 'tmsvg/pear-tree'
    use 'pantharshit00/vim-prisma'
	use 'editorconfig/editorconfig-vim'
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			view = {
				side = "right"
			}
		} end
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'udalov/kotlin-vim'
	use 'posva/vim-vue'
	use {
		'williamboman/mason.nvim'
	}
	use 'williamboman/mason-lspconfig.nvim'
	use "pangloss/vim-javascript"
	use "folke/trouble.nvim"
	use "winston0410/commented.nvim"
	use {
		'andweeb/presence.nvim',
		config = function ()
			require('presence'):setup({})
		end
	}
	use  {
		"prettier/vim-prettier",
		run="yarn install --frozen-lockfile --production"
	}
	use "styled-components/vim-styled-components"
	use "jose-elias-alvarez/null-ls.nvim"
end)
