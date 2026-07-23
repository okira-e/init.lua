-- Tokyo Night Storm, written as a standalone colorscheme. No plugin required.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "tokyonight"

local p = {
  bg        = "#1a1b26",
  bg_dark   = "#16161e",
  bg_float  = "#1f2335",
  bg_highlight = "#292e42",
  bg_visual = "#364a82",
  fg        = "#c0caf5",
  fg_dark   = "#a9b1d6",
  fg_gutter = "#3b4261",
  comment   = "#565f89",
  black     = "#414868",

  red       = "#f7768e",
  red1      = "#db4b4b",
  orange    = "#ff9e64",
  yellow    = "#e0af68",
  green     = "#9ece6a",
  green1    = "#73daca",
  teal      = "#1abc9c",
  cyan      = "#7dcfff",
  blue      = "#7aa2f7",
  blue1     = "#2ac3de",
  blue5     = "#89ddff",
  blue6     = "#b4f9f8",
  purple    = "#9d7cd8",
  magenta   = "#bb9af7",
  magenta2  = "#ff007c",
}

local diff = {
  add    = "#20303b",
  change = "#1f2d4a",
  delete = "#37222c",
  text   = "#394b70",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- Editor UI
  Normal       = { fg = p.fg, bg = p.bg },
  NormalNC     = { fg = p.fg, bg = p.bg },
  NormalFloat  = { fg = p.fg, bg = p.bg_float },
  FloatBorder  = { fg = p.black, bg = p.bg_float },
  FloatTitle   = { fg = p.blue, bg = p.bg_float, bold = true },
  Cursor       = { fg = p.bg, bg = p.orange },
  lCursor      = { fg = p.bg, bg = p.orange },
  TermCursor   = { fg = p.bg, bg = p.orange },
  CursorLine   = { bg = p.bg_highlight },
  CursorColumn = { bg = p.bg_highlight },
  ColorColumn  = { bg = p.bg_dark },
  LineNr       = { fg = p.fg_gutter },
  CursorLineNr = { fg = p.yellow },
  SignColumn   = { fg = p.fg_gutter, bg = p.bg },
  FoldColumn   = { fg = p.fg_gutter, bg = p.bg },
  Folded       = { fg = p.comment, bg = p.bg_highlight },
  Visual       = { bg = p.bg_visual },
  VisualNOS    = { bg = p.bg_visual },
  MatchParen   = { fg = p.orange, bg = p.bg_highlight, bold = true },
  Search       = { fg = p.bg, bg = p.yellow },
  IncSearch    = { fg = p.bg, bg = p.orange },
  CurSearch    = { fg = p.bg, bg = p.orange },
  Substitute   = { fg = p.bg, bg = p.red },
  WinSeparator = { fg = p.bg_highlight },
  VertSplit    = { fg = p.bg_highlight },
  EndOfBuffer  = { fg = p.bg },
  NonText      = { fg = p.fg_gutter },
  Whitespace   = { fg = p.fg_gutter },
  SpecialKey   = { fg = p.fg_gutter },
  Conceal      = { fg = p.comment },
  Directory    = { fg = p.blue },
  Title        = { fg = p.blue, bold = true },

  -- Messages / cmdline
  ModeMsg    = { fg = p.fg },
  MoreMsg    = { fg = p.green },
  Question   = { fg = p.green },
  ErrorMsg   = { fg = p.red, bold = true },
  WarningMsg = { fg = p.yellow },
  MsgArea    = { fg = p.fg },

  -- Statusline / tabline
  StatusLine   = { fg = p.fg, bg = p.bg_highlight },
  StatusLineNC = { fg = p.comment, bg = p.bg_dark },
  TabLine      = { fg = p.comment, bg = p.bg },
  TabLineSel   = { fg = p.fg, bg = p.bg_highlight },
  TabLineFill  = { bg = p.bg },
  WinBar       = { fg = p.fg, bg = p.bg },
  WinBarNC     = { fg = p.comment, bg = p.bg },

  -- Popup menu
  Pmenu        = { fg = p.fg, bg = p.bg_float },
  PmenuSel     = { fg = p.bg, bg = p.blue },
  PmenuSbar    = { bg = p.bg_float },
  PmenuThumb   = { bg = p.black },
  WildMenu     = { fg = p.bg, bg = p.blue },
  QuickFixLine = { bg = p.bg_highlight },

  -- Base syntax
  Comment        = { fg = p.comment, italic = true },
  Constant       = { fg = p.orange },
  String         = { fg = p.green },
  Character      = { fg = p.green },
  Number         = { fg = p.orange },
  Boolean        = { fg = p.orange },
  Float          = { fg = p.orange },
  Identifier     = { fg = p.fg },
  Function       = { fg = p.blue },
  Statement      = { fg = p.magenta },
  Conditional    = { fg = p.magenta },
  Repeat         = { fg = p.magenta },
  Label          = { fg = p.magenta },
  Operator       = { fg = p.blue5 },
  Keyword        = { fg = p.magenta },
  Exception      = { fg = p.magenta },
  PreProc        = { fg = p.cyan },
  Include        = { fg = p.magenta },
  Define         = { fg = p.cyan },
  Macro          = { fg = p.cyan },
  PreCondit      = { fg = p.cyan },
  Type           = { fg = p.blue1 },
  StorageClass   = { fg = p.magenta },
  Structure      = { fg = p.blue1 },
  Typedef        = { fg = p.blue1 },
  Special        = { fg = p.cyan },
  SpecialChar    = { fg = p.orange },
  Tag            = { fg = p.red },
  Delimiter      = { fg = p.fg_dark },
  SpecialComment = { fg = p.comment, italic = true },
  Debug          = { fg = p.orange },
  Underlined     = { fg = p.blue, underline = true },
  Ignore         = { fg = p.comment },
  Error          = { fg = p.red },
  Todo           = { fg = p.blue, bold = true },

  -- Treesitter captures
  ["@comment"]               = { fg = p.comment, italic = true },
  ["@comment.documentation"] = { fg = p.comment, italic = true },
  ["@variable"]              = { fg = p.fg },
  ["@variable.builtin"]      = { fg = p.red },
  ["@variable.parameter"]    = { fg = p.yellow },
  ["@variable.member"]       = { fg = p.green1 },
  ["@property"]              = { fg = p.green1 },
  ["@field"]                 = { fg = p.green1 },

  ["@constant"]         = { fg = p.orange },
  ["@constant.builtin"] = { fg = p.orange },
  ["@constant.macro"]   = { fg = p.orange },
  ["@number"]           = { fg = p.orange },
  ["@number.float"]     = { fg = p.orange },
  ["@boolean"]          = { fg = p.orange },

  ["@string"]                = { fg = p.green },
  ["@string.regexp"]         = { fg = p.blue6 },
  ["@string.escape"]         = { fg = p.magenta },
  ["@string.special"]        = { fg = p.magenta },
  ["@string.special.symbol"] = { fg = p.magenta },
  ["@string.special.url"]    = { fg = p.blue, underline = true },
  ["@character"]             = { fg = p.green },
  ["@character.special"]     = { fg = p.magenta },

  ["@function"]             = { fg = p.blue },
  ["@function.call"]        = { fg = p.blue },
  ["@function.builtin"]     = { fg = p.cyan },
  ["@function.macro"]       = { fg = p.cyan },
  ["@function.method"]      = { fg = p.blue },
  ["@function.method.call"] = { fg = p.blue },
  ["@constructor"]          = { fg = p.cyan },
  ["@attribute"]            = { fg = p.yellow },

  ["@type"]            = { fg = p.blue1 },
  ["@type.builtin"]    = { fg = p.blue1 },
  ["@type.definition"] = { fg = p.blue1 },
  ["@type.qualifier"]  = { fg = p.magenta },

  ["@keyword"]             = { fg = p.magenta },
  ["@keyword.function"]    = { fg = p.magenta },
  ["@keyword.operator"]    = { fg = p.magenta },
  ["@keyword.import"]      = { fg = p.magenta },
  ["@keyword.storage"]     = { fg = p.magenta },
  ["@keyword.repeat"]      = { fg = p.magenta },
  ["@keyword.return"]      = { fg = p.magenta },
  ["@keyword.conditional"] = { fg = p.magenta },
  ["@keyword.exception"]   = { fg = p.magenta },
  ["@keyword.directive"]   = { fg = p.cyan },
  ["@keyword.coroutine"]   = { fg = p.magenta },

  ["@operator"]              = { fg = p.blue5 },
  ["@punctuation.delimiter"] = { fg = p.fg_dark },
  ["@punctuation.bracket"]   = { fg = p.fg_dark },
  ["@punctuation.special"]   = { fg = p.cyan },

  ["@module"]    = { fg = p.blue1 },
  ["@namespace"] = { fg = p.blue1 },
  ["@label"]     = { fg = p.magenta },

  ["@tag"]           = { fg = p.red },
  ["@tag.attribute"] = { fg = p.orange },
  ["@tag.delimiter"] = { fg = p.fg_dark },

  -- Markup
  ["@markup.heading"]       = { fg = p.blue, bold = true },
  ["@markup.strong"]        = { fg = p.orange, bold = true },
  ["@markup.italic"]        = { fg = p.orange, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.green },
  ["@markup.raw.block"]     = { fg = p.green },
  ["@markup.link"]          = { fg = p.blue },
  ["@markup.link.label"]    = { fg = p.cyan },
  ["@markup.link.url"]      = { fg = p.blue, underline = true },
  ["@markup.list"]          = { fg = p.orange },
  ["@markup.quote"]         = { fg = p.comment, italic = true },
  ["@markup.math"]          = { fg = p.purple },

  ["@diff.plus"]  = { fg = p.green },
  ["@diff.minus"] = { fg = p.red },
  ["@diff.delta"] = { fg = p.yellow },

  -- LSP semantic tokens
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

  -- Diagnostics
  DiagnosticError = { fg = p.red },
  DiagnosticWarn  = { fg = p.yellow },
  DiagnosticInfo  = { fg = p.blue },
  DiagnosticHint  = { fg = p.cyan },
  DiagnosticOk    = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.red },
  DiagnosticVirtualTextWarn  = { fg = p.yellow },
  DiagnosticVirtualTextInfo  = { fg = p.blue },
  DiagnosticVirtualTextHint  = { fg = p.cyan },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.blue },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.cyan },
  DiagnosticUnnecessary = { fg = p.comment },
  DiagnosticDeprecated  = { strikethrough = true },

  LspInlayHint = { fg = p.comment, bg = p.bg_highlight },
  LspReferenceText  = { bg = p.bg_highlight },
  LspReferenceRead  = { bg = p.bg_highlight },
  LspReferenceWrite = { bg = p.bg_highlight },

  -- vimdiff
  DiffAdd    = { bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.red, bg = diff.delete },
  DiffText   = { bg = diff.text },

  -- Spell
  SpellBad   = { undercurl = true, sp = p.red },
  SpellCap   = { undercurl = true, sp = p.yellow },
  SpellRare  = { undercurl = true, sp = p.purple },
  SpellLocal = { undercurl = true, sp = p.cyan },

  -- gitsigns
  GitSignsAdd          = { fg = p.green },
  GitSignsChange       = { fg = p.yellow },
  GitSignsDelete       = { fg = p.red },
  GitSignsTopdelete    = { fg = p.red },
  GitSignsChangedelete = { fg = p.orange },
  GitSignsUntracked    = { fg = p.comment },

  -- snacks picker UI
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.blue, bg = p.bg_float },
  SnacksPickerDir    = { fg = p.comment },
  SnacksPickerFile   = { fg = p.fg },
  SnacksPickerMatch  = { fg = p.magenta, bold = true },
  SnacksPickerPrompt = { fg = p.blue },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.bg, bg = p.blue },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
