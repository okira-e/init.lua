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
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Keep normal yanks in Neovim registers. Use explicit mappings/commands for
-- the system clipboard instead.
opt.clipboard = ""

-- Persistent undo across sessions.
opt.undofile = true

-- Create parent directories automatically for new file buffers, so
-- `:edit path/to/new-file` is enough even when `path/to` does not exist yet.
local function ensure_parent_dir(args)
  if vim.bo[args.buf].buftype ~= "" then
    return
  end

  local file = vim.api.nvim_buf_get_name(args.buf)
  if file == "" or file:match("^%w[%w+.-]*://") then
    return
  end

  local dir = vim.fs.dirname(file)
  if dir and vim.fn.isdirectory(dir) == 0 then
    local ok, err = pcall(vim.fn.mkdir, dir, "p")
    if not ok then
      vim.notify(("Could not create directory %s: %s"):format(dir, err), vim.log.levels.ERROR)
    end
  end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("AutoCreateParentDirs", { clear = true }),
  callback = ensure_parent_dir,
  desc = "Create parent directories for new files",
})

-- Snappier UI / git signs updates; shorter mapped-sequence timeout.
opt.updatetime = 250
opt.timeoutlen = 400

-- Mouse available if you want it (resize splits, scroll).
opt.mouse = "a"

-- Native completion menu behavior (used by the built-in LSP completion).
opt.completeopt = "menu,menuone,noselect"

-- Native command-line completion. Tab first extends the longest common path and
-- opens the menu; further Tabs cycle matches. While the menu is visible,
-- Up/Down and the Ctrl-p/Ctrl-n mappings in keymaps.lua navigate it.
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum,tagfile"
opt.pumheight = 12

-- Let :find search recursively from the working directory without descending
-- into dependency, VCS, or generated-output directories.
opt.path:append("**")
opt.wildignore:append({
  "*/.git/*",
  "*/node_modules/*",
  "*/dist/*",
  "*/build/*",
  "*/target/*",
  "*/.next/*",
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

-- Spell checking. Uses Neovim's built-in speller, so no plugin and no lockfile
-- entry. Two deliberate properties:
--
--   * Misspellings are highlighted via the SpellBad/SpellCap syntax groups, not
--     the diagnostics system — so they never appear under <leader>d, which only
--     reads vim.diagnostic. That separation is free; nothing here suppresses it.
--   * The personal word list (added with `zg`) is pinned to Neovim's global data
--     dir instead of the default (the config's own spell/ dir). This keeps `zg`
--     from ever writing a spell file into whatever project you're editing —
--     including this config repo.
--
-- Built-in keys once spell is on: ]s/[s jump between misspellings, z= lists
-- suggestions, zg marks a word good, zw marks it wrong.
-- "en" (not "en_us"): the generic English dictionary ships bundled with Neovim,
-- so it loads with no download. "en_us" would require fetching a separate .spl
-- and errors with E756 if that download is declined or unavailable offline.
opt.spelllang = "en"
opt.spelloptions = "camel" -- treat CamelCase segments as separate words
local spellfile = vim.fn.stdpath("data") .. "/spell/en.utf-8.add"
vim.fn.mkdir(vim.fs.dirname(spellfile), "p")
opt.spellfile = spellfile

-- Off by default; toggle it on with :Spell (see lua/config/commands.lua). When
-- enabled, buffers with Treesitter highlighting only check @spell regions
-- (comments, strings, prose) and leave identifiers alone; buffers without it
-- check all words.
opt.spell = false
