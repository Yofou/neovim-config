local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
	function (server_name)
		lspconfig[server_name].setup {}
	end,

	["lua_ls"] = function ()
		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			}
		}
	end,
	['denols'] = function ()
		lspconfig.denols.setup {
			root_dir = lspconfig.util.root_pattern("deno.json"),
			init_options = {
				lint = true,
			},
		}
	end,
	['tsserver'] = function ()
		lspconfig.tsserver.setup {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/usr/lib/node_modules/@vue/typescript-plugin",
						languages = {"javascript", "typescript", "vue"},
					},
				},
			},
			filetypes = {
				"javascript",
				"typescript",
				"vue",
			},
		}
	end,

	['cssls'] = function ()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.cssls.setup {
			capabilities = capabilities
		}
	end,
}

-- local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		-- Add this back in later if tab is still breaking sometimes
		-- ['<Tab>'] = function(fallback)
			-- if cmp.visible() then
				-- cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
				-- luasnip.expand_or_jump()
			-- else
				-- fallback()
			-- end
		-- end,
		-- ['<S-Tab>'] = function(fallback)
			-- if cmp.visible() then
				-- cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
				-- luasnip.jump(-1)
			-- else
				-- fallback()
			-- end
		-- end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" }
	},
}
