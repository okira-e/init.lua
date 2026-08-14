-- latte (custom) — hand-written Catppuccin Latte, the light variant.
-- Standalone colorscheme: no plugin. Palette is the official Catppuccin Latte
-- hexes; scope→group mappings follow Catppuccin's canonical assignments, with
-- Neovim-only groups (vimdiff, search, spell, picker) derived to stay on-palette.
-- Structured to mirror colors/ayu.lua so the two are easy to diff.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "light"
vim.g.colors_name = "latte"

-- Official Catppuccin Latte palette (verbatim).
local p = {
  rosewater = "#dc8a78",
  flamingo  = "#dd7878",
  pink      = "#ea76cb",
  mauve     = "#8839ef",
  red       = "#d20f39",
  maroon    = "#e64553",
  peach     = "#fe640b",
  yellow    = "#df8e1d",
  green     = "#40a02b",
  teal      = "#179299",
  sky       = "#04a5e5",
  sapphire  = "#209fb5",
  blue      = "#1e66f5",
  lavender  = "#7287fd",

  text      = "#4c4f69",
  subtext1  = "#5c5f77",
  subtext0  = "#6c6f85",
  overlay2  = "#7c7f93",
  overlay1  = "#8c8fa1",
  overlay0  = "#9ca0b0",
  surface2  = "#acb0be",
  surface1  = "#bcc0cc",
  surface0  = "#ccd0da",
  base      = "#eff1f5",
  mantle    = "#e6e9ef",
  crust     = "#dce0e8",
}

-- Light diff backgrounds Neovim needs that Catppuccin's scopes don't define;
-- kept pale and on-palette.
local diff = {
  add    = "#e5efdd",
  change = "#e0e8f5",
  delete = "#f5dfe2",
  text   = "#cfe0c4",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- ── Editor UI ────────────────────────────────────────────────────────────
  Normal       = { fg = p.text, bg = p.base },
  NormalNC     = { fg = p.text, bg = p.base },
  NormalFloat  = { fg = p.text, bg = p.mantle },
  FloatBorder  = { fg = p.blue, bg = p.mantle },
  FloatTitle   = { fg = p.blue, bg = p.mantle, bold = true },
  Cursor       = { fg = p.base, bg = p.mauve },
  lCursor      = { fg = p.base, bg = p.mauve },
  TermCursor   = { fg = p.base, bg = p.mauve },
  CursorLine   = { bg = p.crust },
  CursorColumn = { bg = p.crust },
  ColorColumn  = { bg = p.mantle },
  LineNr       = { fg = p.surface1 },
  CursorLineNr = { fg = p.text },
  SignColumn   = { fg = p.surface1, bg = p.base },
  FoldColumn   = { fg = p.surface1, bg = p.base },
  Folded       = { fg = p.blue, bg = p.surface0 },
  Visual       = { bg = p.surface1 },
  VisualNOS    = { bg = p.surface1 },
  MatchParen   = { fg = p.peach, bold = true },
  Search       = { fg = p.base, bg = p.yellow },
  IncSearch    = { fg = p.base, bg = p.peach },
  CurSearch    = { fg = p.base, bg = p.peach },
  Substitute   = { fg = p.base, bg = p.red },
  WinSeparator = { fg = p.surface0 },
  VertSplit    = { fg = p.surface0 },
  EndOfBuffer  = { fg = p.base },
  NonText      = { fg = p.surface1 },
  Whitespace   = { fg = p.surface1 },
  SpecialKey   = { fg = p.surface1 },
  Conceal      = { fg = p.overlay1 },
  Directory    = { fg = p.blue },
  Title        = { fg = p.blue, bold = true },

  -- Messages / cmdline
  ModeMsg    = { fg = p.text },
  MoreMsg    = { fg = p.green },
  Question   = { fg = p.green },
  ErrorMsg   = { fg = p.red, bold = true },
  WarningMsg = { fg = p.yellow },
  MsgArea    = { fg = p.text },

  -- Statusline / tabline
  StatusLine   = { fg = p.text, bg = p.mantle },
  StatusLineNC = { fg = p.overlay0, bg = p.mantle },
  TabLine      = { fg = p.overlay0, bg = p.mantle },
  TabLineSel   = { fg = p.text, bg = p.surface0 },
  TabLineFill  = { bg = p.base },
  WinBar       = { fg = p.text, bg = p.base },
  WinBarNC     = { fg = p.overlay0, bg = p.base },

  -- Popup menu
  Pmenu        = { fg = p.text, bg = p.mantle },
  PmenuSel     = { fg = p.text, bg = p.surface1 },
  PmenuSbar    = { bg = p.mantle },
  PmenuThumb   = { bg = p.surface1 },
  WildMenu     = { fg = p.base, bg = p.blue },
  QuickFixLine = { bg = p.surface0 },

  -- ── Base syntax (fallbacks for non-Treesitter buffers) ───────────────────
  Comment        = { fg = p.overlay0, italic = true },
  Constant       = { fg = p.peach },
  String         = { fg = p.green },
  Character      = { fg = p.teal },
  Number         = { fg = p.peach },
  Boolean        = { fg = p.peach },
  Float          = { fg = p.peach },
  Identifier     = { fg = p.text },
  Function       = { fg = p.blue },
  Statement      = { fg = p.mauve },
  Conditional    = { fg = p.mauve },
  Repeat         = { fg = p.mauve },
  Label          = { fg = p.sapphire },
  Operator       = { fg = p.sky },
  Keyword        = { fg = p.mauve },
  Exception      = { fg = p.mauve },
  PreProc        = { fg = p.pink },
  Include        = { fg = p.mauve },
  Define         = { fg = p.pink },
  Macro          = { fg = p.pink },
  PreCondit      = { fg = p.pink },
  Type           = { fg = p.yellow },
  StorageClass   = { fg = p.yellow },
  Structure      = { fg = p.yellow },
  Typedef        = { fg = p.yellow },
  Special        = { fg = p.pink },
  SpecialChar    = { fg = p.pink },
  Tag            = { fg = p.mauve },
  Delimiter      = { fg = p.overlay2 },
  SpecialComment = { fg = p.overlay0, italic = true },
  Debug          = { fg = p.peach },
  Underlined     = { fg = p.blue, underline = true },
  Ignore         = { fg = p.overlay0 },
  Error          = { fg = p.red },
  Todo           = { fg = p.base, bg = p.yellow, bold = true },

  -- ── Treesitter captures (Catppuccin canonical scopes) ────────────────────
  ["@comment"]               = { fg = p.overlay0, italic = true },
  ["@comment.documentation"] = { fg = p.overlay0, italic = true },
  ["@variable"]              = { fg = p.text },
  ["@variable.builtin"]      = { fg = p.red },
  ["@variable.parameter"]    = { fg = p.maroon },
  ["@variable.member"]       = { fg = p.teal },
  ["@property"]              = { fg = p.teal },
  ["@field"]                 = { fg = p.teal },

  ["@constant"]         = { fg = p.peach },
  ["@constant.builtin"] = { fg = p.peach },
  ["@constant.macro"]   = { fg = p.mauve },
  ["@number"]           = { fg = p.peach },
  ["@number.float"]     = { fg = p.peach },
  ["@boolean"]          = { fg = p.peach },

  ["@string"]                = { fg = p.green },
  ["@string.regexp"]         = { fg = p.pink },
  ["@string.escape"]         = { fg = p.pink },
  ["@string.special"]        = { fg = p.pink },
  ["@string.special.symbol"] = { fg = p.flamingo },
  ["@string.special.url"]    = { fg = p.rosewater, underline = true },
  ["@character"]             = { fg = p.teal },
  ["@character.special"]     = { fg = p.pink },

  ["@function"]             = { fg = p.blue },
  ["@function.call"]        = { fg = p.blue },
  ["@function.builtin"]     = { fg = p.peach },
  ["@function.macro"]       = { fg = p.teal },
  ["@function.method"]      = { fg = p.blue },
  ["@function.method.call"] = { fg = p.blue },
  ["@constructor"]          = { fg = p.sapphire },
  ["@attribute"]            = { fg = p.yellow },

  ["@type"]            = { fg = p.yellow },
  ["@type.builtin"]    = { fg = p.yellow, italic = true },
  ["@type.definition"] = { fg = p.yellow },
  ["@type.qualifier"]  = { fg = p.mauve },

  ["@keyword"]             = { fg = p.mauve },
  ["@keyword.function"]    = { fg = p.mauve },
  ["@keyword.operator"]    = { fg = p.mauve },
  ["@keyword.import"]      = { fg = p.mauve },
  ["@keyword.storage"]     = { fg = p.yellow },
  ["@keyword.repeat"]      = { fg = p.mauve },
  ["@keyword.return"]      = { fg = p.mauve },
  ["@keyword.conditional"] = { fg = p.mauve },
  ["@keyword.exception"]   = { fg = p.mauve },
  ["@keyword.directive"]   = { fg = p.pink },
  ["@keyword.coroutine"]   = { fg = p.mauve },

  ["@operator"]             = { fg = p.sky },
  ["@punctuation.delimiter"]= { fg = p.overlay2 },
  ["@punctuation.bracket"]  = { fg = p.overlay2 },
  ["@punctuation.special"]  = { fg = p.sky },

  ["@module"]    = { fg = p.lavender, italic = true },
  ["@namespace"] = { fg = p.lavender, italic = true },
  ["@label"]     = { fg = p.sapphire },

  ["@tag"]           = { fg = p.mauve },
  ["@tag.attribute"] = { fg = p.teal },
  ["@tag.delimiter"] = { fg = p.sky },

  -- Markup (markdown etc.)
  ["@markup.heading"]       = { fg = p.blue, bold = true },
  ["@markup.strong"]        = { fg = p.maroon, bold = true },
  ["@markup.italic"]        = { fg = p.maroon, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.teal },
  ["@markup.raw.block"]     = { fg = p.teal },
  ["@markup.link"]          = { fg = p.blue },
  ["@markup.link.label"]    = { fg = p.blue },
  ["@markup.link.url"]      = { fg = p.rosewater, underline = true },
  ["@markup.list"]          = { fg = p.teal },
  ["@markup.quote"]         = { fg = p.subtext0, italic = true },
  ["@markup.math"]          = { fg = p.blue },

  ["@diff.plus"]  = { fg = p.green },
  ["@diff.minus"] = { fg = p.red },
  ["@diff.delta"] = { fg = p.blue },

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

  -- ── Diagnostics ──────────────────────────────────────────────────────────
  DiagnosticError = { fg = p.red },
  DiagnosticWarn  = { fg = p.yellow },
  DiagnosticInfo  = { fg = p.sky },
  DiagnosticHint  = { fg = p.teal },
  DiagnosticOk    = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.red },
  DiagnosticVirtualTextWarn  = { fg = p.yellow },
  DiagnosticVirtualTextInfo  = { fg = p.sky },
  DiagnosticVirtualTextHint  = { fg = p.teal },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.sky },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.teal },
  DiagnosticUnnecessary = { fg = p.overlay0 },
  DiagnosticDeprecated  = { strikethrough = true },

  -- Inlay hints
  LspInlayHint = { fg = p.overlay1, bg = p.mantle },

  -- LSP reference highlight under cursor
  LspReferenceText  = { bg = p.surface1 },
  LspReferenceRead  = { bg = p.surface1 },
  LspReferenceWrite = { bg = p.surface1 },

  -- ── vimdiff ──────────────────────────────────────────────────────────────
  DiffAdd    = { bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.red, bg = diff.delete },
  DiffText   = { bg = diff.text },

  -- ── Spell ─────────────────────────────────────────────────────────────────
  SpellBad   = { undercurl = true, sp = p.red },
  SpellCap   = { undercurl = true, sp = p.yellow },
  SpellRare  = { undercurl = true, sp = p.mauve },
  SpellLocal = { undercurl = true, sp = p.sky },

  -- ── gitsigns ──────────────────────────────────────────────────────────────
  GitSignsAdd          = { fg = p.green },
  GitSignsChange       = { fg = p.yellow },
  GitSignsDelete       = { fg = p.red },
  GitSignsTopdelete    = { fg = p.red },
  GitSignsChangedelete = { fg = p.yellow },
  GitSignsUntracked    = { fg = p.overlay0 },

  -- ── snacks picker UI ───────────────────────────────────────────────────────
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.blue, bg = p.mantle },
  SnacksPickerDir    = { fg = p.overlay0 },
  SnacksPickerFile   = { fg = p.text },
  SnacksPickerMatch  = { fg = p.blue, bold = true },
  SnacksPickerPrompt = { fg = p.blue },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.base, bg = p.blue },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
