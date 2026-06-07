local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

return require("pckr").add{
    'dag/vim-fish';
    {
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
	};
    'nvim-lualine/lualine.nvim';
    'neovim/nvim-lspconfig';
    'tmsvg/pear-tree';
    'pantharshit00/vim-prisma';
	'editorconfig/editorconfig-vim';
	{
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			view = {
				side = "right"
			}
		} end,
	};
	{
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	};
	'hrsh7th/nvim-cmp'; -- Autocompletion plugin
	'hrsh7th/cmp-nvim-lsp'; -- LSP source for nvim-cmp
	'saadparwaiz1/cmp_luasnip';
	'L3MON4D3/LuaSnip'; -- Snippets plugin
	'udalov/kotlin-vim';
	{
		'williamboman/mason.nvim'
	};
	'williamboman/mason-lspconfig.nvim';
	"folke/trouble.nvim";
	"winston0410/commented.nvim";
	{
		'andweeb/presence.nvim',
		config = function ()
			require('presence'):setup({})
		end
	};
	"styled-components/vim-styled-components";
	"nvimtools/none-ls.nvim";
	"kamykn/spelunker.vim";
	"nvim-treesitter/nvim-treesitter";
	"nvim-treesitter/nvim-treesitter-context";
	"JoosepAlviste/nvim-ts-context-commentstring";
	"norcalli/nvim-colorizer.lua";
	{
		"mcchrish/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		requires = "rktjmp/lush.nvim"
	};
	"eliba2/vim-node-inspect";
	{
		"adelarsq/image_preview.nvim",
		config = function ()
			require("image_preview").setup({})
		end
	};
	"dgox16/oldworld.nvim";
	"sindrets/diffview.nvim";
}
