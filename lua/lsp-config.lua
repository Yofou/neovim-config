local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = vim.lsp.config
require("mason").setup()
require("mason-lspconfig").setup {}
local Path = require("plenary.path");

local function fix_all(opts)
  opts = opts or {}

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  vim.validate("bufnr", bufnr, "number")

  local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]

  if not client then return end

  local request

  if opts.sync then
    request = function(buf, method, params) client:request_sync(method, params, nil, buf) end
  else
    request = function(buf, method, params) client:request(method, params, nil, buf) end
  end

  request(bufnr, "workspace/executeCommand", {
    command = "eslint.applyAllFixes",
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = vim.lsp.util.buf_versions[bufnr],
      },
    },
  })
end

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
		vim.lsp.config.ts_ls = {
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
            importModuleSpecifier = "relative"
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
      },
      on_init = function(client)
        vim.api.nvim_create_user_command("EslintFixAll", function() fix_all({ client = client, sync = true }) end, {})
      end,
		}
	end,
}

vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--query-driver=/Users/nathanewen/.espressif/tools/xtensa-esp-elf/**/xtensa-esp*-elf-g++,/Users/nathanewen/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-g++",
  },
}

setup_handlers["lua_ls"]()
setup_handlers["tsserver"]()
-- setup_handlers["denols"]()
setup_handlers["cssls"]()
setup_handlers["eslint"]()

-- local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup {
  window = {
    completion = {
      border = "rounded",       -- rounded uses │ ─ corners etc
      winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
      col_offset = -3,
      side_padding = 1,         -- this is the padding (0 = none, 1 = one space each side)
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder",
    },
  },
  format = function(entry, vim_item)
    vim_item = lspkind.cmp_format({

    })(entry, vim_item)

    local kind = vim_item.kind or "Text"
    vim_item.kind = " " .. kind .. " "
    vim_item.kind_hl_group = "CmpItemKind" .. kind
    vim_item.menu = ""         -- clear menu so it doesn't show source name
    vim_item.menu_hl_group = "CmpItemKind" .. kind  -- extend bg into menu column

    return vim_item
  end,
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
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" }
	},
}

vim.api.nvim_set_hl(0, "CmpSel", { bg = "#343434", bold = true })
