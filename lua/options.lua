-- options.lua - General Neovim settings

local opt = vim.opt

-- Line numbers
opt.number = false         -- Show line numbers
opt.relativenumber = false -- Show relative line numbers

-- Tabs & Indentation
opt.tabstop = 4           -- spaces for tabs
opt.shiftwidth = 4        -- spaces for indent width
opt.expandtab = true      -- Use spaces instead of tabs
opt.autoindent = true     -- Copy indent from current line when starting new one
opt.smartindent = true    -- Smart autoindenting when starting a new line

-- Line wrapping
opt.wrap = true           -- Disable line wrapping

-- Search settings
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- If you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true       -- Highlight all matches on previous search pattern
opt.incsearch = true      -- Show matches while typing

-- Cursor line
opt.cursorline = false    -- Highlight the current line
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block" -- Cursor block

-- Appearance
opt.termguicolors = true  -- More vivid colors
opt.background = "dark"   -- Use dark mode
opt.signcolumn = "yes"    -- Always show the signcolumn
-- opt.colorcolumn = "120"   -- Line length marker
opt.scrolloff = 8         -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor when scrolling horizontally

-- Backspace
opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

-- Clipboard
-- opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Split windows
opt.splitright = true     -- Split windows to the right
opt.splitbelow = true     -- Split windows to the bottom

-- Consider strings with dash as whole word
opt.iskeyword:append("-")

-- Decrease update time
opt.updatetime = 1000     -- Faster completion (default: 4000ms)
opt.timeoutlen = 1000     -- Time to wait for a mapped sequence (default: 1000ms)

-- Enable persistent undo
opt.undofile = true

-- Disable swap files
opt.swapfile = false

-- Save more items in session
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
