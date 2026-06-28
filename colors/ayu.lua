-- ayu (custom) — hand-ported from the user's Helix theme
-- (~/.config/helix/themes/ayu.toml). Standalone colorscheme: no plugin.
-- Palette and scope→group mappings mirror that TOML exactly; Neovim-only groups
-- (vimdiff backgrounds, search, spell) are derived to stay consistent.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "ayu"

-- [palette] from the TOML, verbatim.
local p = {
  background = "#0f1419",
  foreground = "#bfbdb6",
  black      = "#131721",
  blue       = "#59c2ff",
  cursorline = "#1f2933",
  dark_gray  = "#2d3640",
  cyan       = "#73b8ff",
  gray       = "#5c6773",
  green      = "#aad94c",
  magenta    = "#d2a6ff",
  orange     = "#ff8f40",
  red        = "#f07178",
  yellow     = "#e6b450",
}

-- Neovim needs subtle line backgrounds for vimdiff that Helix doesn't define;
-- kept dark and on-palette.
local diff = {
  add    = "#1c2a1a",
  change = "#22262e",
  delete = "#2a1b1d",
  text   = "#33401f",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- ── Editor UI ────────────────────────────────────────────────────────────
  Normal       = { fg = p.foreground, bg = p.background },
  NormalNC     = { fg = p.foreground, bg = p.background },
  NormalFloat  = { fg = p.foreground, bg = p.black },           -- ui.popup
  FloatBorder  = { fg = p.dark_gray, bg = p.black },            -- ui.window
  FloatTitle   = { fg = p.orange, bg = p.black, bold = true },
  Cursor       = { fg = p.dark_gray, bg = p.orange },           -- ui.cursor.primary
  lCursor      = { fg = p.dark_gray, bg = p.orange },
  TermCursor   = { fg = p.dark_gray, bg = p.orange },
  CursorLine   = { bg = p.cursorline },                         -- ui.cursorline
  CursorColumn = { bg = p.cursorline },
  ColorColumn  = { bg = p.black },                              -- ui.virtual.ruler
  LineNr       = { fg = p.dark_gray },                          -- ui.linenr
  CursorLineNr = { fg = p.gray },                               -- ui.linenr.selected
  SignColumn   = { fg = p.gray, bg = p.background },
  FoldColumn   = { fg = p.gray, bg = p.background },
  Folded       = { fg = p.gray, bg = p.black },
  Visual       = { bg = p.dark_gray },                          -- ui.selection
  VisualNOS    = { bg = p.dark_gray },
  MatchParen   = { fg = p.orange, bold = true },                -- ui.cursor.match
  Search       = { fg = p.background, bg = p.yellow },
  IncSearch    = { fg = p.background, bg = p.orange },
  CurSearch    = { fg = p.background, bg = p.orange },
  Substitute   = { fg = p.background, bg = p.red },
  WinSeparator = { fg = p.dark_gray },
  VertSplit    = { fg = p.dark_gray },
  EndOfBuffer  = { fg = p.background },
  NonText      = { fg = p.dark_gray },                          -- ui.virtual.whitespace
  Whitespace   = { fg = p.dark_gray },
  SpecialKey   = { fg = p.dark_gray },
  Conceal      = { fg = p.gray },
  Directory    = { fg = p.blue },
  Title        = { fg = p.orange, bold = true },

  -- Messages / cmdline
  ModeMsg    = { fg = p.foreground },
  MoreMsg    = { fg = p.green },
  Question   = { fg = p.green },
  ErrorMsg   = { fg = p.red, bold = true },                     -- error
  WarningMsg = { fg = p.yellow },                               -- warning
  MsgArea    = { fg = p.foreground },

  -- Statusline / tabline (no plugin; matches ui.statusline / ui.bufferline)
  StatusLine   = { fg = p.foreground, bg = p.black },
  StatusLineNC = { fg = p.gray, bg = p.black },
  TabLine      = { fg = p.gray, bg = p.background },
  TabLineSel   = { fg = p.foreground, bg = p.dark_gray },
  TabLineFill  = { bg = p.background },
  WinBar       = { fg = p.foreground, bg = p.background },
  WinBarNC     = { fg = p.gray, bg = p.background },

  -- Popup menu (ui.menu / ui.menu.selected)
  Pmenu        = { fg = p.foreground, bg = p.black },
  PmenuSel     = { fg = p.background, bg = p.gray },
  PmenuSbar    = { bg = p.black },
  PmenuThumb   = { bg = p.dark_gray },
  WildMenu     = { fg = p.background, bg = p.gray },
  QuickFixLine = { bg = p.dark_gray },

  -- ── Base syntax (fallbacks for non-Treesitter buffers) ───────────────────
  Comment        = { fg = p.gray, italic = true },
  Constant       = { fg = p.magenta },
  String         = { fg = p.green },
  Character      = { fg = p.green },
  Number         = { fg = p.magenta },
  Boolean        = { fg = p.magenta },
  Float          = { fg = p.magenta },
  Identifier     = { fg = p.foreground },
  Function       = { fg = p.yellow },
  Statement      = { fg = p.orange },
  Conditional    = { fg = p.orange },
  Repeat         = { fg = p.orange },
  Label          = { fg = p.orange },
  Operator       = { fg = p.orange },
  Keyword        = { fg = p.orange },
  Exception      = { fg = p.orange },
  PreProc        = { fg = p.orange },
  Include        = { fg = p.orange },
  Define         = { fg = p.orange },
  Macro          = { fg = p.orange },
  PreCondit      = { fg = p.orange },
  Type           = { fg = p.blue },
  StorageClass   = { fg = p.orange },
  Structure      = { fg = p.blue },
  Typedef        = { fg = p.blue },
  Special        = { fg = p.orange },                           -- special
  SpecialChar    = { fg = p.yellow },
  Tag            = { fg = p.blue },
  Delimiter      = { fg = p.foreground },
  SpecialComment = { fg = p.gray, italic = true },
  Debug          = { fg = p.orange },
  Underlined     = { fg = p.blue, underline = true },
  Ignore         = { fg = p.gray },
  Error          = { fg = p.red },
  Todo           = { fg = p.orange, bold = true },

  -- ── Treesitter captures (faithful to the TOML scopes) ────────────────────
  ["@comment"]               = { fg = p.gray, italic = true },
  ["@comment.documentation"] = { fg = p.gray, italic = true },
  ["@variable"]              = { fg = p.foreground },
  ["@variable.builtin"]      = { fg = p.foreground },
  ["@variable.parameter"]    = { fg = p.foreground },
  ["@variable.member"]       = { fg = p.foreground },
  ["@property"]              = { fg = p.foreground },
  ["@field"]                 = { fg = p.foreground },

  ["@constant"]         = { fg = p.magenta },
  ["@constant.builtin"] = { fg = p.magenta },
  ["@constant.macro"]   = { fg = p.magenta },
  ["@number"]           = { fg = p.magenta },
  ["@number.float"]     = { fg = p.magenta },
  ["@boolean"]          = { fg = p.magenta },

  ["@string"]                = { fg = p.green },
  ["@string.regexp"]         = { fg = p.orange },               -- string.regexp
  ["@string.escape"]         = { fg = p.yellow },               -- string.special
  ["@string.special"]        = { fg = p.yellow },
  ["@string.special.symbol"] = { fg = p.yellow },
  ["@string.special.url"]    = { fg = p.blue, underline = true },
  ["@character"]             = { fg = p.green },
  ["@character.special"]     = { fg = p.orange },

  ["@function"]             = { fg = p.yellow },
  ["@function.call"]        = { fg = p.yellow },
  ["@function.builtin"]     = { fg = p.yellow },
  ["@function.macro"]       = { fg = p.yellow },
  ["@function.method"]      = { fg = p.yellow },
  ["@function.method.call"] = { fg = p.yellow },
  ["@constructor"]          = { fg = p.green },                 -- constructor
  ["@attribute"]            = { fg = p.orange },

  ["@type"]            = { fg = p.blue },
  ["@type.builtin"]    = { fg = p.blue },
  ["@type.definition"] = { fg = p.blue },
  ["@type.qualifier"]  = { fg = p.orange },

  ["@keyword"]             = { fg = p.orange },
  ["@keyword.function"]    = { fg = p.orange },
  ["@keyword.operator"]    = { fg = p.orange },
  ["@keyword.import"]      = { fg = p.orange },
  ["@keyword.storage"]     = { fg = p.orange },
  ["@keyword.repeat"]      = { fg = p.orange },
  ["@keyword.return"]      = { fg = p.orange },
  ["@keyword.conditional"] = { fg = p.orange },
  ["@keyword.exception"]   = { fg = p.orange },
  ["@keyword.directive"]   = { fg = p.orange },
  ["@keyword.coroutine"]   = { fg = p.orange },

  ["@operator"]             = { fg = p.orange },
  ["@punctuation.delimiter"]= { fg = p.foreground },
  ["@punctuation.bracket"]  = { fg = p.foreground },
  ["@punctuation.special"]  = { fg = p.foreground },

  ["@module"]    = { fg = p.blue },                             -- namespace
  ["@namespace"] = { fg = p.blue },
  ["@label"]     = { fg = p.orange },                           -- label

  ["@tag"]           = { fg = p.blue },                         -- tag
  ["@tag.attribute"] = { fg = p.yellow },
  ["@tag.delimiter"] = { fg = p.foreground },

  -- Markup (markdown etc.)
  ["@markup.heading"]       = { fg = p.orange, bold = true },
  ["@markup.strong"]        = { fg = p.orange, bold = true },
  ["@markup.italic"]        = { fg = p.orange, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.orange },
  ["@markup.raw.block"]     = { fg = p.orange },
  ["@markup.link"]          = { fg = p.yellow },                -- markup.link.text
  ["@markup.link.label"]    = { fg = p.green },                 -- markup.link.label
  ["@markup.link.url"]      = { fg = p.blue, underline = true },
  ["@markup.list"]          = { fg = p.yellow },                -- markup.list
  ["@markup.quote"]         = { fg = p.yellow, italic = true }, -- markup.quote
  ["@markup.math"]          = { fg = p.magenta },

  ["@diff.plus"]  = { fg = p.green },                           -- diff.plus
  ["@diff.minus"] = { fg = p.red },                             -- diff.minus
  ["@diff.delta"] = { fg = p.yellow },                          -- diff.delta

  -- ── LSP semantic tokens → align with the Treesitter mapping ──────────────
  ["@lsp.type.namespace"]     = { link = "@module" },
  ["@lsp.type.type"]          = { link = "@type" },
  ["@lsp.type.class"]         = { link = "@type" },
  ["@lsp.type.enum"]          = { link = "@type" },
  ["@lsp.type.interface"]     = { link = "@type" },
  ["@lsp.type.struct"]        = { link = "@type" },
  ["@lsp.type.typeParameter"] = { link = "@type" },
  ["@lsp.type.parameter"]     = { link = "@variable.parameter" },
  ["@lsp.type.variable"]      = { link = "@variable" },
  ["@lsp.type.property"]      = { link = "@property" },
  ["@lsp.type.enumMember"]    = { link = "@constant" },
  ["@lsp.type.function"]      = { link = "@function" },
  ["@lsp.type.method"]        = { link = "@function.method" },
  ["@lsp.type.macro"]         = { link = "@function.macro" },
  ["@lsp.type.keyword"]       = { link = "@keyword" },
  ["@lsp.type.comment"]       = { link = "@comment" },
  ["@lsp.type.string"]        = { link = "@string" },
  ["@lsp.type.number"]        = { link = "@number" },
  ["@lsp.type.operator"]      = { link = "@operator" },
  ["@lsp.type.decorator"]     = { link = "@attribute" },

  -- ── Diagnostics (warning/error/info/hint + curl underlines) ──────────────
  DiagnosticError = { fg = p.red },
  DiagnosticWarn  = { fg = p.yellow },
  DiagnosticInfo  = { fg = p.blue },
  DiagnosticHint  = { fg = p.blue },
  DiagnosticOk    = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.red },
  DiagnosticVirtualTextWarn  = { fg = p.yellow },
  DiagnosticVirtualTextInfo  = { fg = p.blue },
  DiagnosticVirtualTextHint  = { fg = p.blue },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.blue },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.blue },
  DiagnosticUnnecessary = { fg = p.gray },                      -- diagnostic.unnecessary (dim)
  DiagnosticDeprecated  = { strikethrough = true },             -- diagnostic.deprecated

  -- Inlay hints (ui.virtual.inlay-hint)
  LspInlayHint = { fg = p.yellow, bg = "#302a20" },

  -- LSP reference highlight under cursor
  LspReferenceText  = { bg = p.dark_gray },
  LspReferenceRead  = { bg = p.dark_gray },
  LspReferenceWrite = { bg = p.dark_gray },

  -- ── vimdiff ──────────────────────────────────────────────────────────────
  DiffAdd    = { bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.red, bg = diff.delete },
  DiffText   = { bg = diff.text },

  -- ── Spell ─────────────────────────────────────────────────────────────────
  SpellBad   = { undercurl = true, sp = p.red },
  SpellCap   = { undercurl = true, sp = p.yellow },
  SpellRare  = { undercurl = true, sp = p.magenta },
  SpellLocal = { undercurl = true, sp = p.blue },

  -- ── gitsigns ──────────────────────────────────────────────────────────────
  GitSignsAdd          = { fg = p.green },                      -- diff.plus
  GitSignsChange       = { fg = p.yellow },                     -- diff.delta
  GitSignsDelete       = { fg = p.red },                        -- diff.minus
  GitSignsTopdelete    = { fg = p.red },
  GitSignsChangedelete = { fg = p.yellow },
  GitSignsUntracked    = { fg = p.gray },

  -- ── snacks picker UI ───────────────────────────────────────────────────────
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.orange, bg = p.black },
  SnacksPickerDir    = { fg = p.gray },
  SnacksPickerFile   = { fg = p.foreground },
  SnacksPickerMatch  = { fg = p.orange, bold = true },          -- fuzzy match chars
  SnacksPickerPrompt = { fg = p.orange },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.background, bg = p.gray },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
