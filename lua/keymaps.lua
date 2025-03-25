-- keymaps.lua - Key mappings

-- Helper function for mapping keys
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

---------------------
-- General Keymaps
---------------------

-- Map j and k to not skip visual lines when line wrapping
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Use jk to exit insert mode
map("i", "jk", "<ESC>")

-- Clear search highlights
map("n", "<ESC>", ":nohlsearch<CR>")

-- Set "Y" to yank to system clipboard
map("v", "Y", '"+yy')

-- Delete single character without copying into register
map("n", "x", '"_x')

-- Delete the previous word while typing with opt + delete
map("i", "<M-BS>", "<C-w>")

-- Better window navigation
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-l>", "<C-w>l")

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- -- Navigate buffers
-- map("n", "<S-l>", ":bnext<CR>")
-- map("n", "<S-h>", ":bprevious<CR>")

-- Improved indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Better paste
map("v", "p", '"_dP')

-- Quick save
map("n", "<leader>w", ":w<CR>")
-- map("n", "<leader>q", ":q<CR>")
-- map("n", "<leader>Q", ":qa!<CR>")

-- Quick split
-- map("n", "<leader>v", ":vsplit<CR>")
-- map("n", "<leader>s", ":split<CR>")
