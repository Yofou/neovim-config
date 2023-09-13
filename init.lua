require("plugins")
require("theme")
require("lsp-config")
require("comment")

vim.filetype.add({
	extension = {
		mdx = "markdown.mdx",
	},
	filename = {},
	pattern = {},
})

vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.clipboard = "unnamedplus"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.spelunker_highlight_type = 2

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

-- Move between tabs left & right
map("n", "<A-Left>", ":BufferPrevious<CR>", opt)
map("n", "<A-Right>", ":BufferNext<CR>", opt)
map("n", "<A-q>", ":BufferClose<CR>", opt)

-- Move panels in all direction useing Ctrl + <Arrow Keys>
map("n", "<C-Left>", "<C-W>h", opt)
map("n", "<C-Down>", "<C-W>j", opt)
map("n", "<C-Up>", "<C-W>k", opt)
map("n", "<C-Right>", "<C-W>l", opt)

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function(data)
		-- buffer is a directory
		local directory = vim.fn.isdirectory(data.file) == 1

		if not directory then
			return
		end

		-- change to the directory
		vim.cmd.cd(data.file)
		require("nvim-tree.api").tree.open()
	end,
})
