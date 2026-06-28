-- Entry point. Keep this thin: leader first, then options, then plugins.
-- Leader must be set before lazy.nvim loads so plugin keymaps register correctly.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.statusline")
require("config.keymaps")
require("config.commands")
require("config.lazy")

-- Active colorscheme (standalone, defined in colors/ayu.lua). Applied after
-- plugins so it has the final say over any default highlight groups they set.
vim.cmd.colorscheme("ayu")
