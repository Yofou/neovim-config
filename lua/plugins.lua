return require("packer").startup(function (use)
    use 'dag/vim-fish'
    use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = "make"} },
		config = function ()
			require("telescope").setup({
				defaults = {
					entry_prefix = " ",
					scroll_strategy = "limit",
					prompt_prefix = "   ",
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					layout_config = {
						horizontal = {
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = {
						".git/",
						"venv",
						"node_modules/",
					},
					dynamic_preview_title = true,
					vimgrep_arguments = {
						"rg",
						"--ignore",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('fzf')
		end
	}
    use 'nvim-lualine/lualine.nvim'
    use 'neovim/nvim-lspconfig'
    use 'tmsvg/pear-tree'
    use 'pantharshit00/vim-prisma'
	use 'editorconfig/editorconfig-vim'
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			view = {
				side = "right"
			}
		} end,
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
	use {
		'williamboman/mason.nvim'
	}
	use 'williamboman/mason-lspconfig.nvim'
	--  use "pangloss/vim-javascript"
	use "folke/trouble.nvim"
	use "winston0410/commented.nvim"
	use {
		'andweeb/presence.nvim',
		config = function ()
			require('presence'):setup({})
		end
	}
	use "styled-components/vim-styled-components"
	use "jose-elias-alvarez/null-ls.nvim"
	use "kamykn/spelunker.vim"
	use "nvim-treesitter/nvim-treesitter"
	use "nvim-treesitter/nvim-treesitter-context"
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use "norcalli/nvim-colorizer.lua"
	use {
		"mcchrish/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		requires = "rktjmp/lush.nvim"
	}
	use "eliba2/vim-node-inspect"
	use {
		"adelarsq/image_preview.nvim",
		config = function ()
			require("image_preview").setup({})
		end
	}

	use "dgox16/oldworld.nvim"
end)
