-- jblow — standalone Neovim port of ../helix/themes/jblow.toml.
-- Inspired by Jonathan Blow's Emacs setup: dark green UI, white keywords,
-- light-green builtin types, and intentionally minimal syntax highlighting.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "jblow"

local p = {
  bg             = "#052B2A",
  fg             = "#D0C0A6",
  keyword        = "#EAF4F4",
  type_builtin   = "#9FED9B",

  surface        = "#08221d",
  panel_bg       = "#081a12",
  statusline_bg  = "#DBBD9A",
  active_line    = "#10301f",
  selection      = "#1a4030",
  element_active = "#1f4d3a",
  border         = "#163826",

  comment        = "#63C157",
  muted          = "#7a6e58",
  string         = "#3AC4AA",
  literal        = "#A6F0E2",
  linenr         = "#3a5544",
  linenr_active  = "#9aab78",
  invisible      = "#2a4030",
  indent_guide   = "#234030",

  warning        = "#d4a060",
  error_red      = "#c46060",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- Editor UI
  Normal       = { fg = p.fg, bg = p.bg },
  NormalNC     = { fg = p.fg, bg = p.bg },
  NormalFloat  = { fg = p.fg, bg = p.surface },
  FloatBorder  = { fg = p.border, bg = p.surface },
  FloatTitle   = { fg = p.keyword, bg = p.surface, bold = true },
  Cursor       = { fg = p.bg, bg = p.type_builtin },
  lCursor      = { fg = p.bg, bg = p.type_builtin },
  TermCursor   = { fg = p.bg, bg = p.type_builtin },
  CursorLine   = { bg = p.active_line },
  CursorColumn = { bg = p.active_line },
  ColorColumn  = { bg = p.active_line },
  LineNr       = { fg = p.linenr },
  CursorLineNr = { fg = p.linenr_active },
  SignColumn   = { fg = p.linenr, bg = p.bg },
  FoldColumn   = { fg = p.linenr, bg = p.bg },
  Folded       = { fg = p.muted, bg = p.surface },
  Visual       = { bg = p.selection },
  VisualNOS    = { bg = p.selection },
  MatchParen   = { bg = p.active_line, bold = true },
  Search       = { fg = p.bg, bg = p.warning },
  IncSearch    = { fg = p.bg, bg = p.keyword },
  CurSearch    = { fg = p.bg, bg = p.keyword },
  Substitute   = { fg = p.bg, bg = p.error_red },
  WinSeparator = { fg = p.border },
  VertSplit    = { fg = p.border },
  EndOfBuffer  = { fg = p.bg },
  NonText      = { fg = p.invisible },
  Whitespace   = { fg = p.invisible },
  SpecialKey   = { fg = p.muted },
  Conceal      = { fg = p.muted },
  Directory    = { fg = p.type_builtin },
  Title        = { fg = p.keyword, bold = true },

  -- Messages / cmdline
  ModeMsg    = { fg = p.fg },
  MoreMsg    = { fg = p.type_builtin },
  Question   = { fg = p.type_builtin },
  ErrorMsg   = { fg = p.error_red, bold = true },
  WarningMsg = { fg = p.warning },
  MsgArea    = { fg = p.fg },

  -- Statusline / tabline
  StatusLine   = { fg = p.bg, bg = p.statusline_bg },
  StatusLineNC = { fg = p.muted, bg = p.statusline_bg },
  TabLine      = { fg = p.muted, bg = p.panel_bg },
  TabLineSel   = { fg = p.keyword, bg = p.bg, bold = true },
  TabLineFill  = { bg = p.panel_bg },
  WinBar       = { fg = p.fg, bg = p.bg },
  WinBarNC     = { fg = p.muted, bg = p.bg },

  -- Popup menu
  Pmenu        = { fg = p.fg, bg = p.surface },
  PmenuSel     = { fg = p.keyword, bg = p.element_active },
  PmenuSbar    = { fg = p.muted, bg = p.surface },
  PmenuThumb   = { bg = p.muted },
  WildMenu     = { fg = p.keyword, bg = p.element_active },
  QuickFixLine = { bg = p.active_line },

  -- Base syntax: intentionally quiet.
  Comment        = { fg = p.comment, italic = true },
  Constant       = { fg = p.fg },
  String         = { fg = p.string },
  Character      = { fg = p.string },
  Number         = { fg = p.literal },
  Boolean        = { fg = p.literal },
  Float          = { fg = p.literal },
  Identifier     = { fg = p.fg },
  Function       = { fg = p.fg },
  Statement      = { fg = p.keyword },
  Conditional    = { fg = p.keyword },
  Repeat         = { fg = p.keyword },
  Label          = { fg = p.fg },
  Operator       = { fg = p.fg },
  Keyword        = { fg = p.keyword },
  Exception      = { fg = p.keyword },
  PreProc        = { fg = p.keyword },
  Include        = { fg = p.keyword },
  Define         = { fg = p.keyword },
  Macro          = { fg = p.fg },
  PreCondit      = { fg = p.keyword },
  Type           = { fg = p.type_builtin },
  StorageClass   = { fg = p.keyword },
  Structure      = { fg = p.type_builtin },
  Typedef        = { fg = p.type_builtin },
  Special        = { fg = p.fg },
  SpecialChar    = { fg = p.string },
  Tag            = { fg = p.keyword },
  Delimiter      = { fg = p.fg },
  SpecialComment = { fg = p.comment, italic = true },
  Debug          = { fg = p.fg },
  Underlined     = { fg = p.type_builtin, underline = true },
  Ignore         = { fg = p.muted },
  Error          = { fg = p.error_red },
  Todo           = { fg = p.keyword, bold = true },

  -- Treesitter captures
  ["@comment"]               = { fg = p.comment, italic = true },
  ["@comment.documentation"] = { fg = p.comment, italic = true },
  ["@variable"]              = { fg = p.fg },
  ["@variable.builtin"]      = { fg = p.keyword },
  ["@variable.parameter"]    = { fg = p.fg },
  ["@variable.member"]       = { fg = p.fg },
  ["@property"]              = { fg = p.fg },
  ["@field"]                 = { fg = p.fg },

  ["@constant"]         = { fg = p.fg },
  ["@constant.builtin"] = { fg = p.literal },
  ["@constant.macro"]   = { fg = p.fg },
  ["@number"]           = { fg = p.literal },
  ["@number.float"]     = { fg = p.literal },
  ["@boolean"]          = { fg = p.literal },

  ["@string"]                = { fg = p.string },
  ["@string.regexp"]         = { fg = p.string },
  ["@string.escape"]         = { fg = p.string },
  ["@string.special"]        = { fg = p.string },
  ["@string.special.symbol"] = { fg = p.string },
  ["@string.special.url"]    = { fg = p.string },
  ["@character"]             = { fg = p.string },
  ["@character.special"]     = { fg = p.string },

  ["@function"]             = { fg = p.fg },
  ["@function.call"]        = { fg = p.fg },
  ["@function.builtin"]     = { fg = p.fg },
  ["@function.macro"]       = { fg = p.fg },
  ["@function.method"]      = { fg = p.fg },
  ["@function.method.call"] = { fg = p.fg },
  ["@constructor"]          = { fg = p.fg },
  ["@attribute"]            = { fg = p.fg },

  ["@type"]            = { fg = p.type_builtin },
  ["@type.builtin"]    = { fg = p.type_builtin },
  ["@type.definition"] = { fg = p.type_builtin },
  ["@type.qualifier"]  = { fg = p.keyword },

  ["@keyword"]             = { fg = p.keyword },
  ["@keyword.function"]    = { fg = p.keyword },
  ["@keyword.operator"]    = { fg = p.fg },
  ["@keyword.import"]      = { fg = p.keyword },
  ["@keyword.storage"]     = { fg = p.keyword },
  ["@keyword.repeat"]      = { fg = p.keyword },
  ["@keyword.return"]      = { fg = p.keyword },
  ["@keyword.conditional"] = { fg = p.keyword },
  ["@keyword.exception"]   = { fg = p.keyword },
  ["@keyword.directive"]   = { fg = p.keyword },
  ["@keyword.coroutine"]   = { fg = p.keyword },

  ["@operator"]              = { fg = p.fg },
  ["@punctuation.delimiter"] = { fg = p.fg },
  ["@punctuation.bracket"]   = { fg = p.fg },
  ["@punctuation.special"]   = { fg = p.fg },

  ["@module"]    = { fg = p.fg },
  ["@namespace"] = { fg = p.fg },
  ["@label"]     = { fg = p.fg },

  ["@tag"]           = { fg = p.keyword },
  ["@tag.attribute"] = { fg = p.fg },
  ["@tag.delimiter"] = { fg = p.fg },

  -- Markup
  ["@markup.heading"]       = { fg = p.keyword, bold = true },
  ["@markup.strong"]        = { fg = p.fg, bold = true },
  ["@markup.italic"]        = { fg = p.fg, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.fg },
  ["@markup.raw.block"]     = { fg = p.fg },
  ["@markup.link"]          = { fg = p.fg },
  ["@markup.link.label"]    = { fg = p.type_builtin },
  ["@markup.link.url"]      = { fg = p.type_builtin, underline = true },
  ["@markup.list"]          = { fg = p.fg },
  ["@markup.quote"]         = { fg = p.muted, italic = true },
  ["@markup.math"]          = { fg = p.fg },

  ["@diff.plus"]  = { fg = p.type_builtin },
  ["@diff.minus"] = { fg = p.error_red },
  ["@diff.delta"] = { fg = p.keyword },

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
  DiagnosticError = { fg = p.error_red },
  DiagnosticWarn  = { fg = p.warning },
  DiagnosticInfo  = { fg = p.type_builtin },
  DiagnosticHint  = { fg = p.muted },
  DiagnosticOk    = { fg = p.type_builtin },
  DiagnosticVirtualTextError = { fg = p.error_red },
  DiagnosticVirtualTextWarn  = { fg = p.warning },
  DiagnosticVirtualTextInfo  = { fg = p.type_builtin },
  DiagnosticVirtualTextHint  = { fg = p.muted },
  DiagnosticUnderlineError = { undercurl = true, sp = p.error_red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.warning },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.type_builtin },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.muted },
  DiagnosticUnnecessary = { fg = p.muted },
  DiagnosticDeprecated  = { strikethrough = true },

  LspInlayHint = { fg = p.muted, bg = p.bg, italic = true },
  LspReferenceText  = { bg = p.active_line },
  LspReferenceRead  = { bg = p.active_line },
  LspReferenceWrite = { bg = p.active_line },

  -- vimdiff
  DiffAdd    = { fg = p.type_builtin, bg = p.bg },
  DiffChange = { fg = p.keyword, bg = p.bg },
  DiffDelete = { fg = p.error_red, bg = p.bg },
  DiffText   = { bg = p.active_line },

  -- Spell
  SpellBad   = { undercurl = true, sp = p.error_red },
  SpellCap   = { undercurl = true, sp = p.warning },
  SpellRare  = { undercurl = true, sp = p.keyword },
  SpellLocal = { undercurl = true, sp = p.type_builtin },

  -- gitsigns
  GitSignsAdd          = { fg = p.type_builtin },
  GitSignsChange       = { fg = p.keyword },
  GitSignsDelete       = { fg = p.error_red },
  GitSignsTopdelete    = { fg = p.error_red },
  GitSignsChangedelete = { fg = p.keyword },
  GitSignsUntracked    = { fg = p.muted },

  -- snacks picker UI
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.muted, bg = p.surface, bold = true },
  SnacksPickerDir    = { fg = p.muted },
  SnacksPickerFile   = { fg = p.fg },
  SnacksPickerMatch  = { fg = p.keyword, bold = true },
  SnacksPickerPrompt = { fg = p.keyword },
  SnacksPickerCursorLine = { bg = p.active_line },
  SnacksPickerToggle = { fg = p.keyword, bg = p.element_active },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
