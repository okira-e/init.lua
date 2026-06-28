-- Editor behavior. Tuned to feel close to Helix: minimal, block caret,
-- soft line wrapping, no surprises.

-- node-finder. Only acts when `node` isn't already on PATH, so on machines that
-- expose node normally (typical on Windows/Linux) this is a complete no-op.
-- On this Mac, node is a shell *alias* (~/Apps/node/<version>/bin), invisible to
-- Neovim-spawned LSP servers (ts_ls, the web servers, bashls). Glob those installs
-- and prepend the newest. The glob returns nothing on other machines, so the whole
-- block self-disables — nothing here is required for the config to work elsewhere.
if vim.fn.executable("node") == 0 then
  local sep = vim.fn.has("win32") == 1 and ";" or ":"
  local bins = vim.fn.glob(vim.fn.expand("~/Apps/node/*/bin"), true, true)
  if #bins > 0 then
    table.sort(bins) -- version strings sort so the newest ends up last
    vim.env.PATH = bins[#bins] .. sep .. vim.env.PATH
  end
end

local opt = vim.opt

-- Block caret in every mode (Helix-style), no blink. Each entry names the
-- `Cursor` highlight group explicitly so Neovim actually drives the cursor
-- color (the colorscheme sets `Cursor` to ayu orange). Without a named group,
-- the terminal keeps its own cursor color.
opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-Cursor,r-cr-o:block-Cursor,a:blinkon0"

-- Soft line wrapping that breaks at word boundaries and keeps indentation.
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Line numbers + a stable sign column so diagnostics/git signs don't shift text.
opt.number = false
opt.signcolumn = "yes"
opt.cursorline = false

-- Colors. termguicolors is required for modern colorschemes.
opt.termguicolors = true

-- Searching: case-insensitive unless the query has uppercase.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Indentation. Default: real tab characters displayed 4 columns wide. When a file
-- uses spaces (or a different width), guess-indent detects it per-buffer and
-- overrides these on open. See lua/plugins/indent.lua.
opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true

-- Do not continue comments automatically when pressing Enter, o, or O on a
-- commented line. Filetype plugins can reset this per-buffer, so keep it enforced.
opt.formatoptions:remove({ "c", "r", "o" })
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("DisableCommentContinuation", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable automatic comment continuation",
})

-- Splits open where you'd expect.
opt.splitright = true
opt.splitbelow = true

-- Keep some context around the cursor.
opt.scrolloff = 5
opt.sidescrolloff = 8

-- Keep normal yanks in Neovim registers. Use explicit mappings/commands for
-- the system clipboard instead.
opt.clipboard = ""

-- Persistent undo across sessions.
opt.undofile = true

-- Snappier UI / git signs updates; shorter mapped-sequence timeout.
opt.updatetime = 250
opt.timeoutlen = 400

-- Mouse available if you want it (resize splits, scroll).
opt.mouse = "a"

-- Native completion menu behavior (used by the built-in LSP completion).
opt.completeopt = "menu,menuone,noselect"
opt.pumborder = ""
opt.pumwidth = vim.o.columns

-- Command-line completion for paths/commands, e.g. `:e src/<Tab>`.
opt.wildmenu = true
opt.wildmode = "noselect:lastused,full"
opt.wildoptions = "pum"

vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = vim.api.nvim_create_augroup("FileCommandCompletion", { clear = true }),
  pattern = ":",
  callback = function()
    local cmdline = vim.fn.getcmdline()
    local cmd = cmdline:match("^%s*(%S+)")
    local file_commands = {
      e = true, edit = true,
      sp = true, split = true,
      vs = true, vsp = true, vsplit = true,
      tabe = true, tabedit = true, tabnew = true,
    }

    if cmd and file_commands[cmd] and cmdline:match("^%s*%S+%s+") then
      pcall(vim.fn.wildtrigger)
    end
  end,
  desc = "Auto-show path completion for file-opening commands",
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("FullWidthPopupMenu", { clear = true }),
  callback = function()
    vim.o.pumwidth = vim.o.columns
  end,
  desc = "Keep native popup menu full-width",
})

-- Default rounded border on floating windows (hover, signature help,
-- diagnostics). The border frames the content so text no longer runs to the
-- very edge — makes the LSP hover readable without any plugin.
opt.winborder = "rounded"

-- Don't show "-- INSERT --" etc; the cursor shape already tells you the mode.
opt.showmode = false

-- Cross-platform line endings: prefer LF, but open CRLF files without mangling
-- them. New files get LF everywhere (including Windows) for consistent repos.
opt.fileformats = "unix,dos"
opt.fileformat = "unix"
