-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core modules
require("options")    -- General Neovim options
require("keymaps")    -- Key mappings
require("plugins")    -- Plugin management and setup
require("commands")   -- Commands management and setup

-- Set the title of the terminal to tbe the path of the current folder
vim.opt.title = true
vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"


-- vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "zig_muted"
-- vim.cmd.colorscheme "ayu-mirage"
