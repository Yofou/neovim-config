local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = vim.lsp.config
require("mason").setup()
require("mason-lspconfig").setup {}
local Path = require("plenary.path");

local setup_handlers = {
	["lua_ls"] = function ()
		vim.lsp.config.lua_ls = {
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
		vim.lsp.config.denols = {
			root_dir = vim.lsp.config.util.root_pattern("deno.json"),
			init_options = {
				lint = true,
			},
		}
	end,
	['tsserver'] = function ()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --  print('boop')
		vim.lsp.config.tsserver = {
      capabilities = capabilities,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/Users/nathanewen/.local/share/nvm/v20.15.1/lib/node_modules/@vue/typescript-plugin",
						languages = {"javascript", "typescript", "vue"},
					},
				},
        preferences = {
            disableSuggestions = true,
        }
			},
			filetypes = {
				"javascript",
        "javascriptreact",
        "javascript.jsx",
				"typescript",
        "typescriptreact",
        "typescript.tsx",
				"vue",
			},
		}
	end,

	['cssls'] = function ()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.cssls = {
			capabilities = capabilities
		}
	end,

  ['eslint'] = function ()
    local nodePath = Path:new('./.yarn/sdks'):absolute() or ""
		vim.lsp.config.eslint = {
			settings = {
        nodePath = nodePath,
        format = false,
        run = "onType",
        validate = "on",
        workspaceDirectory = {
          mode = "location",
        },
      }
		}
	end,
}

setup_handlers["lua_ls"]()
setup_handlers["tsserver"]()
-- setup_handlers["denols"]()
setup_handlers["cssls"]()
setup_handlers["eslint"]()

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
    ["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
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
