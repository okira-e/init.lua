-- GitHub Dark Default -- a standalone Neovim port of GitHub's Primer theme.
-- The syntax roles follow GitHub's canonical prettylights mapping: purple
-- functions/entities, orange types, red keywords, and pale-blue strings.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "github"

local p = {
  -- background  = "#0d1117",
  background = "#0f1419",  -- Ayu bg color
  inset       = "#010409",
  surface     = "#161b22",
  elevated    = "#21262d",
  border      = "#30363d",
  subtle      = "#484f58",
  muted       = "#7d8590",
  comment     = "#8b949e",
  foreground  = "#e6edf3",
  white       = "#ffffff",

  accent      = "#2f81f7",
  blue        = "#58a6ff",
  blue_bright = "#79c0ff",
  string      = "#a5d6ff",
  cyan        = "#76e3ea",
  green       = "#3fb950",
  green_bright= "#7ee787",
  yellow      = "#d29922",
  yellow_bright = "#f2cc60",
  orange      = "#ffa657",
  red         = "#ff7b72",
  danger      = "#f85149",
  purple      = "#d2a8ff",
  magenta     = "#bc8cff",
  pink        = "#f778ba",

  selection   = "#173452",
  selection_hi= "#1c3e69",
  search      = "#3b3217",
}

local diff = {
  add    = "#12261e",
  change = "#2a2314",
  delete = "#2d1619",
  text   = "#1f6f43",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- Editor UI
  Normal       = { fg = p.foreground, bg = p.background },
  NormalNC     = { fg = p.foreground, bg = p.background },
  NormalFloat  = { fg = p.foreground, bg = p.surface },
  FloatBorder  = { fg = p.border, bg = p.surface },
  FloatTitle   = { fg = p.purple, bg = p.surface, bold = true },
  Cursor       = { fg = p.background, bg = p.orange },
  lCursor      = { fg = p.background, bg = p.orange },
  TermCursor   = { fg = p.background, bg = p.orange },
  CursorLine   = { bg = p.surface },
  CursorColumn = { bg = p.surface },
  ColorColumn  = { bg = p.surface },
  LineNr       = { fg = p.subtle },
  CursorLineNr = { fg = p.foreground, bold = true },
  SignColumn   = { fg = p.muted, bg = p.background },
  FoldColumn   = { fg = p.muted, bg = p.background },
  Folded       = { fg = p.muted, bg = p.surface },
  Visual       = { bg = p.selection },
  VisualNOS    = { bg = p.selection },
  MatchParen   = { fg = p.foreground, bg = p.selection_hi, bold = true },
  Search       = { fg = p.foreground, bg = p.red },
  IncSearch    = { fg = p.background, bg = p.yellow_bright },
  CurSearch    = { fg = p.background, bg = p.yellow_bright },
  Substitute   = { fg = p.white, bg = p.danger },
  WinSeparator = { fg = p.border },
  VertSplit    = { fg = p.border },
  EndOfBuffer  = { fg = p.background },
  NonText      = { fg = p.subtle },
  Whitespace   = { fg = p.border },
  SpecialKey   = { fg = p.subtle },
  Conceal      = { fg = p.muted },
  Directory    = { fg = p.blue },
  Title        = { fg = p.purple, bold = true },

  -- Messages and command line
  ModeMsg    = { fg = p.foreground },
  MoreMsg    = { fg = p.green },
  Question   = { fg = p.green },
  ErrorMsg   = { fg = p.danger, bold = true },
  WarningMsg = { fg = p.yellow },
  MsgArea    = { fg = p.foreground },

  -- Statusline and tabline
  StatusLine   = { fg = p.muted, bg = p.surface },
  StatusLineNC = { fg = p.subtle, bg = p.inset },
  TabLine      = { fg = p.muted, bg = p.inset },
  TabLineSel   = { fg = p.foreground, bg = p.background },
  TabLineFill  = { bg = p.inset },
  WinBar       = { fg = p.foreground, bg = p.background },
  WinBarNC     = { fg = p.muted, bg = p.background },

  -- Popup menu
  Pmenu        = { fg = p.foreground, bg = p.surface },
  PmenuSel     = { fg = p.foreground, bg = p.selection_hi },
  PmenuSbar    = { bg = p.surface },
  PmenuThumb   = { bg = p.subtle },
  WildMenu     = { fg = p.foreground, bg = p.selection_hi },
  QuickFixLine = { bg = p.surface },

  -- Base syntax
  Comment        = { fg = p.comment },
  Constant       = { fg = p.blue_bright },
  String         = { fg = p.string },
  Character      = { fg = p.string },
  Number         = { fg = p.blue_bright },
  Boolean        = { fg = p.blue_bright },
  Float          = { fg = p.blue_bright },
  Identifier     = { fg = p.foreground },
  Function       = { fg = p.purple },
  Statement      = { fg = p.red },
  Conditional    = { fg = p.red },
  Repeat         = { fg = p.red },
  Label          = { fg = p.red },
  Operator       = { fg = p.blue_bright },
  Keyword        = { fg = p.red },
  Exception      = { fg = p.red },
  PreProc        = { fg = p.red },
  Include        = { fg = p.red },
  Define         = { fg = p.red },
  Macro          = { fg = p.blue_bright },
  PreCondit      = { fg = p.red },
  Type           = { fg = p.orange },
  StorageClass   = { fg = p.red },
  Structure      = { fg = p.orange },
  Typedef        = { fg = p.orange },
  Special        = { fg = p.blue_bright },
  SpecialChar    = { fg = p.green_bright },
  Tag            = { fg = p.green_bright },
  Delimiter      = { fg = p.foreground },
  SpecialComment = { fg = p.comment },
  Debug          = { fg = p.orange },
  Underlined     = { fg = p.blue, underline = true },
  Ignore         = { fg = p.muted },
  Error          = { fg = p.danger },
  Todo           = { fg = p.yellow_bright, bold = true },

  -- Treesitter captures
  ["@comment"]               = { fg = p.comment },
  ["@comment.documentation"] = { fg = p.comment },
  ["@comment.todo"]          = { fg = p.yellow_bright, bold = true },
  ["@comment.note"]          = { fg = p.blue_bright, bold = true },
  ["@comment.warning"]       = { fg = p.yellow, bold = true },
  ["@comment.error"]         = { fg = p.danger, bold = true },

  ["@variable"]                   = { fg = p.foreground },
  ["@variable.builtin"]           = { fg = p.blue_bright },
  ["@variable.parameter"]         = { fg = p.foreground },
  ["@variable.parameter.builtin"] = { fg = p.blue_bright },
  ["@variable.member"]            = { fg = p.blue_bright },
  ["@property"]                   = { fg = p.blue_bright },
  ["@field"]                      = { fg = p.blue_bright },

  ["@constant"]         = { fg = p.blue_bright },
  ["@constant.builtin"] = { fg = p.blue_bright },
  ["@constant.macro"]   = { fg = p.blue_bright },
  ["@number"]           = { fg = p.blue_bright },
  ["@number.float"]     = { fg = p.blue_bright },
  ["@boolean"]          = { fg = p.blue_bright },

  ["@string"]                = { fg = p.string },
  ["@string.regexp"]         = { fg = p.green_bright },
  ["@string.escape"]         = { fg = p.green_bright, bold = true },
  ["@string.special"]        = { fg = p.green_bright },
  ["@string.special.symbol"] = { fg = p.blue_bright },
  ["@string.special.path"]   = { fg = p.string },
  ["@string.special.url"]    = { fg = p.string, underline = true },
  ["@character"]             = { fg = p.string },
  ["@character.special"]     = { fg = p.green_bright },

  ["@function"]             = { fg = p.purple },
  ["@function.call"]        = { fg = p.purple },
  ["@function.builtin"]     = { fg = p.purple },
  ["@function.macro"]       = { fg = p.purple },
  ["@function.method"]      = { fg = p.purple },
  ["@function.method.call"] = { fg = p.purple },
  ["@constructor"]          = { fg = p.purple },
  ["@attribute"]            = { fg = p.orange },
  ["@attribute.builtin"]    = { fg = p.orange },

  ["@type"]            = { fg = p.orange },
  ["@type.builtin"]    = { fg = p.red },
  ["@type.definition"] = { fg = p.orange },
  ["@type.qualifier"]  = { fg = p.red },

  ["@keyword"]             = { fg = p.red },
  ["@keyword.function"]    = { fg = p.red },
  ["@keyword.operator"]    = { fg = p.red },
  ["@keyword.import"]      = { fg = p.red },
  ["@keyword.storage"]     = { fg = p.red },
  ["@keyword.repeat"]      = { fg = p.red },
  ["@keyword.return"]      = { fg = p.red },
  ["@keyword.conditional"] = { fg = p.red },
  ["@keyword.exception"]   = { fg = p.red },
  ["@keyword.directive"]   = { fg = p.red },
  ["@keyword.coroutine"]   = { fg = p.red },

  ["@operator"]              = { fg = p.blue_bright },
  ["@punctuation"]           = { fg = p.foreground },
  ["@punctuation.delimiter"] = { fg = p.foreground },
  ["@punctuation.bracket"]   = { fg = p.foreground },
  ["@punctuation.special"]   = { fg = p.blue_bright },

  ["@module"]    = { fg = p.blue_bright },
  ["@namespace"] = { fg = p.blue_bright },
  ["@label"]     = { fg = p.red },

  ["@tag"]           = { fg = p.green_bright },
  ["@tag.builtin"]   = { fg = p.green_bright },
  ["@tag.attribute"] = { fg = p.orange },
  ["@tag.delimiter"] = { fg = p.foreground },

  -- Markup
  ["@markup.heading"]       = { fg = p.blue, bold = true },
  ["@markup.strong"]        = { fg = p.foreground, bold = true },
  ["@markup.italic"]        = { fg = p.foreground, italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"]           = { fg = p.string },
  ["@markup.raw.block"]     = { fg = p.string },
  ["@markup.link"]          = { fg = p.blue_bright },
  ["@markup.link.label"]    = { fg = p.blue_bright },
  ["@markup.link.url"]      = { fg = p.string, underline = true },
  ["@markup.list"]          = { fg = p.yellow_bright },
  ["@markup.quote"]         = { fg = p.green_bright },
  ["@markup.math"]          = { fg = p.purple },

  ["@diff.plus"]  = { fg = p.green },
  ["@diff.minus"] = { fg = p.danger },
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

  -- Diagnostics and inlay/reference highlights
  DiagnosticError = { fg = p.danger },
  DiagnosticWarn  = { fg = p.yellow },
  DiagnosticInfo  = { fg = p.accent },
  DiagnosticHint  = { fg = p.muted },
  DiagnosticOk    = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.danger },
  DiagnosticVirtualTextWarn  = { fg = p.yellow },
  DiagnosticVirtualTextInfo  = { fg = p.accent },
  DiagnosticVirtualTextHint  = { fg = p.muted },
  DiagnosticUnderlineError = { undercurl = true, sp = p.danger },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.accent },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.muted },
  DiagnosticUnnecessary = { fg = p.subtle },
  DiagnosticDeprecated  = { strikethrough = true },
  LspInlayHint = { fg = p.muted, bg = p.surface },
  LspReferenceText  = { bg = p.elevated },
  LspReferenceRead  = { bg = p.elevated },
  LspReferenceWrite = { bg = p.elevated },

  -- Diff and spell
  DiffAdd    = { bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.danger, bg = diff.delete },
  DiffText   = { bg = diff.text },
  SpellBad   = { undercurl = true, sp = p.danger },
  SpellCap   = { undercurl = true, sp = p.yellow },
  SpellRare  = { undercurl = true, sp = p.purple },
  SpellLocal = { undercurl = true, sp = p.blue },

  -- gitsigns
  GitSignsAdd          = { fg = p.green },
  GitSignsChange       = { fg = p.yellow },
  GitSignsDelete       = { fg = p.danger },
  GitSignsTopdelete    = { fg = p.danger },
  GitSignsChangedelete = { fg = p.yellow },
  GitSignsUntracked    = { fg = p.muted },

  -- snacks picker
  SnacksNormal       = { link = "NormalFloat" },
  SnacksWinBorder    = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle  = { fg = p.purple, bg = p.surface },
  SnacksPickerDir    = { fg = p.muted },
  SnacksPickerFile   = { fg = p.foreground },
  SnacksPickerMatch  = { fg = p.orange, bold = true },
  SnacksPickerPrompt = { fg = p.purple },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.foreground, bg = p.selection_hi },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end

-- GitHub Dark terminal colors.
local terminal = {
  "#0d1117", "#ff7b72", "#3fb950", "#d29922",
  "#58a6ff", "#bc8cff", "#39c5cf", "#b1bac4",
  "#161b22", "#ffa198", "#56d364", "#e3b341",
  "#79c0ff", "#d2a8ff", "#56d4dd", "#ffffff",
}
for i, color in ipairs(terminal) do
  vim.g["terminal_color_" .. (i - 1)] = color
end
