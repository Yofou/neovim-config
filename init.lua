require("plugins")
require('lsp-config')

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.termguicolors = true
vim.cmd("colorscheme spaceduck")
vim.g.lightline = { colorscheme = "spaceduck" }
vim.g.polyglot_disabled = { "svelte", "vue" }
vim.o.clipboard = "unnamedplus"

vim.cmd([[
augroup JsonToJsonc
	autocmd! FileType json set filetype=jsonc
augroup END
]])

-- This is to fix pair-tree & telescope having conflicting behaviors
vim.g.pear_tree_ft_disabled = { "TelescopePrompt" }
vim.g.pear_tree_repeatable_expand = 0

local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

-- Save & Quit
map("n", "<C-Q>", ":q!<CR>", opt)
map("n", "<C-S>", ":w<CR>", opt)

map("n", "<C-P>", ":Telescope find_files<CR>", opt)
map("n", "<C-O>", ":Telescope live_grep<CR>", opt)
map("n", "<C-K>", ":NvimTreeToggle<CR>", opt) -- Toggle Folder Tree
map("n", "<S-Up>", "{", opt) -- Next Empty Space Up
map("n", "<S-Down>", "}", opt) -- Next Empty Space Down
map("n", "<C-H>", "v:lua vim.lsp.buf.hover()<CR>", opt) -- opens up more info on cursor
map("n", "<C-J>", "v:lua vim.lsp.buf.definition()<CR>", opt) -- opens up more info on cursor
map("n", "<C-_>", "v:lua.require(\"comment\").empty_comment()", { expr = true, silent = true, noremap = true })
map("v", "<C-_>", "v:lua.require(\"comment\").empty_comment()", { expr = true, silent = true, noremap = true })

-- Movee between tabs left & right
map("n", "<A-Left>", ":BufferPrevious<CR>", opt)
map("n", "<A-Right>", ":BufferNext<CR>", opt)
map("n", "<A-q>", ":BufferClose<CR>", opt)

-- Move panels in all direction useing Ctrl + <Arrow Keys>
map("n", "<C-Left>", "<C-W>h", opt)
map("n", "<C-Down>", "<C-W>j", opt)
map("n", "<C-Up>", "<C-W>k", opt)
map("n", "<C-Right>", "<C-W>l", opt)
