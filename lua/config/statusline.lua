-- Statusline — a native (no-plugin) bar in the spirit of the user's Helix
-- mode-line, expanded to carry the genuinely useful stuff. One global bar
-- (laststatus=3), laid out left → right:
--
--   [MODE]  ⎇ branch +a ~c -d   file [+]            ● err ● warn  ft  enc  L:C  total  sels
--
-- Colors are read back out of the live colorscheme (Normal, Title, String, …)
-- so this never hard-codes the ayu palette and never drifts when colors/ayu.lua
-- changes. Highlight groups are (re)built on every ColorScheme event.

vim.opt.laststatus = 3

local M = {}

-- ── Highlight setup ─────────────────────────────────────────────────────────
-- Pull a hex color out of an existing highlight group so the bar borrows the
-- colorscheme's palette instead of duplicating it.
local function color(group, attr)
  local h = vim.api.nvim_get_hl(0, { name = group, link = false })
  return h[attr] and string.format("#%06x", h[attr]) or nil
end

local function setup_highlights()
  local p = {
    bg      = color("Normal", "bg"),
    fg      = color("Normal", "fg"),
    orange  = color("Title", "fg"),
    green   = color("String", "fg"),
    magenta = color("Constant", "fg"),
    red     = color("ErrorMsg", "fg"),
    blue    = color("Type", "fg"),
    yellow  = color("WarningMsg", "fg"),
    gray    = color("Comment", "fg"),
  }
  local bar = color("StatusLine", "bg") -- the bar's own background

  local hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

  -- Mode block: dark text on a saturated accent, one color per mode family.
  hl("StItemNormal",  { fg = p.bg, bg = p.orange,  bold = true })
  hl("StItemInsert",  { fg = p.bg, bg = p.green,   bold = true })
  hl("StItemVisual",  { fg = p.bg, bg = p.magenta, bold = true })
  hl("StItemReplace", { fg = p.bg, bg = p.red,     bold = true })
  hl("StItemCommand", { fg = p.bg, bg = p.blue,    bold = true })
  hl("StItemTerm",    { fg = p.bg, bg = p.green,   bold = true })

  -- Inline segment colors (on the bar background).
  hl("StBranch",   { fg = p.magenta, bg = bar })
  hl("StGitAdd",   { fg = p.green,   bg = bar })
  hl("StGitChange",{ fg = p.yellow,  bg = bar })
  hl("StGitDelete",{ fg = p.red,     bg = bar })
  hl("StFile",     { fg = p.fg,      bg = bar })
  hl("StModified", { fg = p.yellow,  bg = bar })
  hl("StMuted",    { fg = p.gray,    bg = bar })
  hl("StFiletype", { fg = p.blue,    bg = bar })
end

-- ── Segments ────────────────────────────────────────────────────────────────
-- Each returns a ready-to-place string (with its own %#Group# coloring) or ""
-- when it has nothing to show, so the assembler can drop it cleanly.

-- Helix lets you rename the mode indicators; the user's joke labels carry over:
-- normal → MOVE, insert → BUGS, select/visual → YANK.
local MODES = {
  n      = { "MOVE",    "StItemNormal" },
  no     = { "O-PEND",  "StItemNormal" },
  v      = { "YANK",    "StItemVisual" },
  V      = { "YANK",    "StItemVisual" },
  ["\22"]= { "YANK",    "StItemVisual" },
  s      = { "YANK",    "StItemVisual" },
  S      = { "YANK",    "StItemVisual" },
  ["\19"]= { "YANK",    "StItemVisual" },
  i      = { "BUGS",    "StItemInsert" },
  ic     = { "BUGS",    "StItemInsert" },
  R      = { "REPLACE", "StItemReplace" },
  Rv     = { "V-REPL",  "StItemReplace" },
  c      = { "What?",   "StItemCommand" },
  cv     = { "EX",      "StItemCommand" },
  r      = { "PROMPT",  "StItemCommand" },
  t      = { "TERM",    "StItemTerm" },
}

function M.mode()
  local m = MODES[vim.fn.mode()] or { vim.fn.mode():upper(), "StItemNormal" }
  return "%#" .. m[2] .. "# " .. m[1] .. " %*"
end

function M.git()
  local head = vim.b.gitsigns_head
  if not head or head == "" then return "" end
  local out = { "%#StBranch#⎇ " .. head .. "%*" }
  local d = vim.b.gitsigns_status_dict
  if d then
    if (d.added or 0) > 0 then out[#out + 1] = "%#StGitAdd#+" .. d.added .. "%*" end
    if (d.changed or 0) > 0 then out[#out + 1] = "%#StGitChange#~" .. d.changed .. "%*" end
    if (d.removed or 0) > 0 then out[#out + 1] = "%#StGitDelete#-" .. d.removed .. "%*" end
  end
  return table.concat(out, " ")
end

function M.file()
  local name = vim.api.nvim_buf_get_name(0)
  local label
  if name == "" then
    label = "[No Name]"
  else
    label = vim.fn.fnamemodify(name, ":~:.")
  end
  local out = "%#StFile#" .. label .. "%*"
  if vim.bo.modified then
    out = out .. " %#StModified#●%*"
  elseif vim.bo.readonly or not vim.bo.modifiable then
    out = out .. " %#StMuted#[RO]%*"
  end
  return out
end

function M.diagnostics()
  local buf = vim.api.nvim_get_current_buf()
  local sev = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(buf, { severity = sev.ERROR })
  local warns = #vim.diagnostic.get(buf, { severity = sev.WARN })
  local out = {}
  if errors > 0 then out[#out + 1] = "%#DiagnosticError#● " .. errors .. "%*" end
  if warns > 0 then out[#out + 1] = "%#DiagnosticWarn#● " .. warns .. "%*" end
  return table.concat(out, " ")
end

function M.filetype()
  local ft = vim.bo.filetype
  if ft == "" then return "" end
  return "%#StFiletype#" .. ft .. "%*"
end

-- Encoding: Helix only surfaces this when it isn't plain UTF-8.
function M.encoding()
  local enc = vim.bo.fileencoding
  if enc == "" then enc = vim.o.encoding end
  if enc == "utf-8" then return "" end
  return "%#StMuted#" .. enc .. "%*"
end

-- Position: cursor line:virtual-column, then the buffer's total line count.
function M.position()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local total = vim.api.nvim_buf_line_count(0)
  return "%#StFile#" .. row .. ":" .. vim.fn.virtcol(".") .. "%*"
    .. " %#StMuted#" .. total .. "L%*"
end

-- Selection size — shown only in a visual/select mode (line span for linewise,
-- char count otherwise). This is the Helix `selections` segment, made useful
-- for Neovim's single cursor.
function M.selections()
  local mode = vim.fn.mode()
  local n
  if mode == "V" or mode == "S" then
    n = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1
  elseif mode == "v" or mode == "s" or mode == "\22" or mode == "\19" then
    n = vim.fn.wordcount().visual_chars or 1
  else
    return ""
  end
  return "%#StMuted#" .. n .. (n == 1 and " sel" or " sels") .. "%*"
end

-- ── Assembly ────────────────────────────────────────────────────────────────
local function join(segs)
  local parts = {}
  for _, s in ipairs(segs) do
    if s and s ~= "" then parts[#parts + 1] = s end
  end
  return table.concat(parts, " ")
end

function _G.Statusline()
  local left = join({ M.mode(), M.git(), M.file() })
  local right = join({
    M.selections(),
    M.diagnostics(),
    M.filetype(),
    M.encoding(),
    M.position(),
  })
  -- %< lets the left side truncate first; %= splits left from right.
  return left .. " %<%=" .. right .. " "
end

setup_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_highlights })
vim.opt.statusline = "%!v:lua.Statusline()"

return M
