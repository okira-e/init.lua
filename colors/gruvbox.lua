-- Gruvbox dark, written as a standalone colorscheme. No plugin required.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "gruvbox"

local p = {
  bg0        = "#161616",
  bg1        = "#1d1c1a",
  bg2        = "#282521",
  bg3        = "#34302a",
  bg4        = "#4a4038",
  fg0        = "#fbf1c7",
  fg1        = "#ebdbb2",
  fg2        = "#d5c4a1",
  fg3        = "#bdae93",
  fg4        = "#a89984",
  gray       = "#928374",

  red        = "#e06c5f",
  green      = "#b8bb26",
  yellow     = "#fabd2f",
  blue       = "#83a598",
  purple     = "#d3869b",
  aqua       = "#8ec07c",
  orange     = "#fe8019",

  dark_red    = "#b8564f",
  dark_green  = "#98971a",
  dark_yellow = "#d79921",
  dark_blue   = "#458588",
  dark_purple = "#b16286",
  dark_aqua   = "#689d6a",
  dark_orange = "#d65d0e",
}

local diff = {
  add    = "#202713",
  change = "#172530",
  delete = "#2a1716",
  text   = "#2d2914",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- Editor UI
  Normal       = { fg = p.fg1, bg = p.bg0 },
  NormalNC     = { fg = p.fg1, bg = p.bg0 },
  NormalFloat  = { fg = p.fg1, bg = p.bg1 },
  FloatBorder  = { fg = p.bg4, bg = p.bg1 },
  FloatTitle   = { fg = p.yellow, bg = p.bg1, bold = true },
  Cursor       = { fg = p.bg0, bg = p.orange },
  lCursor      = { fg = p.bg0, bg = p.orange },
  TermCursor   = { fg = p.bg0, bg = p.orange },
  CursorLine   = { bg = p.bg1 },
  CursorColumn = { bg = p.bg1 },
  ColorColumn  = { bg = p.bg1 },
  LineNr       = { fg = p.bg4 },
  CursorLineNr = { fg = p.yellow },
  SignColumn   = { fg = p.bg4, bg = p.bg0 },
  FoldColumn   = { fg = p.bg4, bg = p.bg0 },
  Folded       = { fg = p.gray, bg = p.bg1 },
  Visual       = { bg = p.bg3 },
  VisualNOS    = { bg = p.bg3 },
  MatchParen   = { fg = p.orange, bg = p.bg2, bold = true },
  Search       = { fg = p.bg0, bg = p.yellow },
  IncSearch    = { fg = p.bg0, bg = p.orange },
  CurSearch    = { fg = p.bg0, bg = p.orange },
  Substitute   = { fg = p.bg0, bg = p.red },
  WinSeparator = { fg = p.bg2 },
  VertSplit    = { fg = p.bg2 },
  EndOfBuffer  = { fg = p.bg0 },
  NonText      = { fg = p.bg4 },
  Whitespace   = { fg = p.bg4 },
  SpecialKey   = { fg = p.bg4 },
  Conceal      = { fg = p.gray },
  Directory    = { fg = p.blue },
  Title        = { fg = p.yellow, bold = true },

  -- Messages / cmdline
  ModeMsg    = { fg = p.fg1 },
  MoreMsg    = { fg = p.green },
  Question   = { fg = p.green },
  ErrorMsg   = { fg = p.red, bold = true },
  WarningMsg = { fg = p.yellow },
  MsgArea    = { fg = p.fg1 },

  -- Statusline / tabline
  StatusLine   = { fg = p.fg1, bg = p.bg2 },
  StatusLineNC = { fg = p.gray, bg = p.bg1 },
  TabLine      = { fg = p.gray, bg = p.bg0 },
  TabLineSel   = { fg = p.fg1, bg = p.bg2 },
  TabLineFill  = { bg = p.bg0 },
  WinBar       = { fg = p.fg1, bg = p.bg0 },
  WinBarNC     = { fg = p.gray, bg = p.bg0 },

  -- Popup menu
  Pmenu        = { fg = p.fg1, bg = p.bg1 },
  PmenuSel     = { fg = p.bg0, bg = p.blue },
  PmenuSbar    = { bg = p.bg1 },
  PmenuThumb   = { bg = p.bg4 },
  WildMenu     = { fg = p.bg0, bg = p.blue },
  QuickFixLine = { bg = p.bg2 },

  -- Base syntax
  Comment        = { fg = p.gray, italic = true },
  Constant       = { fg = p.purple },
  String         = { fg = p.green },
  Character      = { fg = p.green },
  Number         = { fg = p.purple },
  Boolean        = { fg = p.purple },
  Float          = { fg = p.purple },
  Identifier     = { fg = p.fg1 },
  Function       = { fg = p.yellow },
  Statement      = { fg = p.red },
  Conditional    = { fg = p.red },
  Repeat         = { fg = p.red },
  Label          = { fg = p.red },
  Operator       = { fg = p.orange },
  Keyword        = { fg = p.red },
  Exception      = { fg = p.red },
  PreProc        = { fg = p.aqua },
  Include        = { fg = p.aqua },
  Define         = { fg = p.aqua },
  Macro          = { fg = p.aqua },
  PreCondit      = { fg = p.aqua },
  Type           = { fg = p.yellow },
  StorageClass   = { fg = p.orange },
  Structure      = { fg = p.yellow },
  Typedef        = { fg = p.yellow },
  Special        = { fg = p.orange },
  SpecialChar    = { fg = p.orange },
  Tag            = { fg = p.blue },
  Delimiter      = { fg = p.fg3 },
  SpecialComment = { fg = p.gray, italic = true },
  Debug          = { fg = p.orange },
  Underlined     = { fg = p.blue, underline = true },
  Ignore         = { fg = p.gray },
  Error          = { fg = p.red },
  Todo           = { fg = p.yellow, bold = true },

  -- Treesitter captures
  ["@comment"]               = { fg = p.gray, italic = true },
  ["@comment.documentation"] = { fg = p.gray, italic = true },
  ["@variable"]              = { fg = p.fg1 },
  ["@variable.builtin"]      = { fg = p.orange },
  ["@variable.parameter"]    = { fg = p.fg2 },
  ["@variable.member"]       = { fg = p.blue },
  ["@property"]              = { fg = p.blue },
  ["@field"]                 = { fg = p.blue },

  ["@constant"]         = { fg = p.purple },
  ["@constant.builtin"] = { fg = p.purple },
  ["@constant.macro"]   = { fg = p.purple },
  ["@number"]           = { fg = p.purple },
  ["@number.float"]     = { fg = p.purple },
  ["@boolean"]          = { fg = p.purple },

  ["@string"]                = { fg = p.green },
  ["@string.regexp"]         = { fg = p.orange },
  ["@string.escape"]         = { fg = p.orange },
  ["@string.special"]        = { fg = p.orange },
  ["@string.special.symbol"] = { fg = p.orange },
  ["@string.special.url"]    = { fg = p.blue, underline = true },
  ["@character"]             = { fg = p.green },
  ["@character.special"]     = { fg = p.orange },

  ["@function"]             = { fg = p.yellow },
  ["@function.call"]        = { fg = p.yellow },
  ["@function.builtin"]     = { fg = p.orange },
  ["@function.macro"]       = { fg = p.aqua },
  ["@function.method"]      = { fg = p.yellow },
  ["@function.method.call"] = { fg = p.yellow },
  ["@constructor"]          = { fg = p.aqua },
  ["@attribute"]            = { fg = p.aqua },

  ["@type"]            = { fg = p.yellow },
  ["@type.builtin"]    = { fg = p.yellow },
  ["@type.definition"] = { fg = p.yellow },
  ["@type.qualifier"]  = { fg = p.red },

  ["@keyword"]             = { fg = p.red },
  ["@keyword.function"]    = { fg = p.red },
  ["@keyword.operator"]    = { fg = p.red },
  ["@keyword.import"]      = { fg = p.aqua },
  ["@keyword.storage"]     = { fg = p.orange },
  ["@keyword.repeat"]      = { fg = p.red },
  ["@keyword.return"]      = { fg = p.red },
  ["@keyword.conditional"] = { fg = p.red },
  ["@keyword.exception"]   = { fg = p.red },
  ["@keyword.directive"]   = { fg = p.aqua },
  ["@keyword.coroutine"]   = { fg = p.red },

  ["@operator"]              = { fg = p.orange },
  ["@punctuation.delimiter"] = { fg = p.fg3 },
  ["@punctuation.bracket"]   = { fg = p.fg3 },
  ["@punctuation.special"]   = { fg = p.orange },

  ["@module"]    = { fg = p.blue },
  ["@namespace"] = { fg = p.blue },
  ["@label"]     = { fg = p.red },

  ["@tag"]           = { fg = p.blue },
  ["@tag.attribute"] = { fg = p.yellow },
  ["@tag.delimiter"] = { fg = p.fg3 },

  -- Markup
  ["@markup.heading"]       = { fg = p.yellow, bold = true },
  ["@markup.strong"]        = { fg = p.orange, bold = true },
  ["@markup.italic"]        = { fg = p.orange, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.green },
  ["@markup.raw.block"]     = { fg = p.green },
  ["@markup.link"]          = { fg = p.blue },
  ["@markup.link.label"]    = { fg = p.aqua },
  ["@markup.link.url"]      = { fg = p.blue, underline = true },
  ["@markup.list"]          = { fg = p.orange },
  ["@markup.quote"]         = { fg = p.gray, italic = true },
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
  DiagnosticHint  = { fg = p.aqua },
  DiagnosticOk    = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.red },
  DiagnosticVirtualTextWarn  = { fg = p.yellow },
  DiagnosticVirtualTextInfo  = { fg = p.blue },
  DiagnosticVirtualTextHint  = { fg = p.aqua },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.blue },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.aqua },
  DiagnosticUnnecessary = { fg = p.gray },
  DiagnosticDeprecated  = { strikethrough = true },

  LspInlayHint = { fg = p.gray, bg = p.bg1 },
  LspReferenceText  = { bg = p.bg2 },
  LspReferenceRead  = { bg = p.bg2 },
  LspReferenceWrite = { bg = p.bg2 },

  -- vimdiff
  DiffAdd    = { bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.red, bg = diff.delete },
  DiffText   = { bg = diff.text },

  -- Spell
  SpellBad   = { undercurl = true, sp = p.red },
  SpellCap   = { undercurl = true, sp = p.yellow },
  SpellRare  = { undercurl = true, sp = p.purple },
  SpellLocal = { undercurl = true, sp = p.blue },

  -- gitsigns
  GitSignsAdd          = { fg = p.green },
  GitSignsChange       = { fg = p.yellow },
  GitSignsDelete       = { fg = p.red },
  GitSignsTopdelete    = { fg = p.red },
  GitSignsChangedelete = { fg = p.orange },
  GitSignsUntracked    = { fg = p.gray },

  -- snacks picker UI
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.yellow, bg = p.bg1 },
  SnacksPickerDir    = { fg = p.gray },
  SnacksPickerFile   = { fg = p.fg1 },
  SnacksPickerMatch  = { fg = p.orange, bold = true },
  SnacksPickerPrompt = { fg = p.orange },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.bg0, bg = p.blue },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
