local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local lspconfig = require('lspconfig')
lspconfig.tailwindcss.setup {}

local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
	local opts = {}

	if (server.name == 'sumneko_lua') then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	end

	if (server.name == 'eslint') then
		opts.filetypes = {
			'javascript',
			'javascriptreact',
			'javascript.jsx',
			'typescript',
			'typescriptreact',
			'typescript.tsx',
			'vue',
			'svelte',
		}

		opts.settings = {
			packageManager = "pnpm"
		}

		opts.on_attach = function (client)
			client.resolved_capabilities.document_formatting = true
		end
	end

	if (server.name == "emmet_ls") then
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		opts = {
			filetypes = { "html", "typescriptreact", "javascriptreact" },
			capabilities = capabilities
		}
	end

	if (server.name == "cssls") then
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		opts = {
			capabilities = capabilities
		}
	end

	server:setup(opts)
end)

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
