-- Fleet Dark — a standalone port of JetBrains Fleet's default dark theme.
--
-- The editor palette and syntax roles follow Fleet Dark. Neovim-only groups
-- (diagnostics, vimdiff, spell, and plugin UI) are derived from that palette.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "fleet"

local p = {
  background = "#181818",
  current_line = "#1f1f1f",
  surface = "#292929",
  surface_high = "#383838",
  border = "#484848",
  line_nr = "#5d5d5d",
  muted = "#898989",
  foreground = "#d1d1d1",
  white = "#ffffff",

  selection = "#194176",
  selection_dim = "#383838",
  blue = "#87c3ff",
  blue_light = "#add1de",
  blue_accent = "#3691f9",
  cyan = "#82d2ce",
  green = "#a8cc7c",
  green_diff = "#4ca988",
  orange = "#e09b70",
  pink = "#e394dc",
  purple = "#c07bf3",
  violet = "#af9cff",
  yellow = "#ebc88d",
  coral = "#cc7c8a",
  red = "#ff5269",
  red_diff = "#ce364d",
  info = "#a366c4",
}

local diff = {
  add = "#134939",
  change = "#132c4f",
  delete = "#390813",
  text = "#163764",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  -- Editor UI
  Normal = { fg = p.foreground, bg = p.background },
  NormalNC = { fg = p.foreground, bg = p.background },
  NormalFloat = { fg = p.foreground, bg = p.surface },
  FloatBorder = { fg = p.surface_high, bg = p.surface },
  FloatTitle = { fg = p.cyan, bg = p.surface, bold = true },
  Cursor = { fg = p.background, bg = p.cyan },
  lCursor = { fg = p.background, bg = p.cyan },
  TermCursor = { fg = p.background, bg = p.cyan },
  CursorLine = { bg = p.current_line },
  CursorColumn = { bg = p.current_line },
  ColorColumn = { bg = p.surface },
  LineNr = { fg = p.line_nr },
  CursorLineNr = { fg = "#c2c2c2", bg = p.current_line, bold = true },
  SignColumn = { fg = p.line_nr, bg = p.background },
  FoldColumn = { fg = p.line_nr, bg = p.background },
  Folded = { fg = p.muted, bg = p.surface },
  Visual = { bg = p.selection },
  VisualNOS = { bg = p.selection_dim },
  MatchParen = { bg = "#163764", bold = true },
  Search = { fg = p.white, bg = p.selection, bold = true },
  IncSearch = { fg = p.background, bg = p.yellow },
  CurSearch = { fg = p.background, bg = p.yellow },
  Substitute = { fg = p.white, bg = p.red_diff },
  WinSeparator = { fg = p.surface_high, bg = p.background },
  VertSplit = { fg = p.surface_high, bg = p.background },
  EndOfBuffer = { fg = p.background },
  NonText = { fg = p.muted },
  Whitespace = { fg = p.surface_high },
  SpecialKey = { fg = p.muted },
  Conceal = { fg = p.muted },
  Directory = { fg = p.cyan },
  Title = { fg = p.cyan, bold = true },

  -- Messages and command line
  ModeMsg = { fg = p.foreground },
  MoreMsg = { fg = p.green },
  Question = { fg = p.green },
  ErrorMsg = { fg = p.red, bold = true },
  WarningMsg = { fg = p.yellow },
  MsgArea = { fg = p.foreground },

  -- Statusline and tabline
  StatusLine = { fg = p.foreground, bg = p.surface },
  StatusLineNC = { fg = p.muted, bg = p.surface },
  TabLine = { fg = p.muted, bg = p.surface },
  TabLineSel = { fg = p.white, bg = p.surface_high },
  TabLineFill = { bg = p.surface },
  WinBar = { fg = p.foreground, bg = p.background },
  WinBarNC = { fg = p.muted, bg = p.background },

  -- Popup menu
  Pmenu = { fg = p.foreground, bg = p.surface },
  PmenuSel = { fg = p.white, bg = p.selection, bold = true },
  PmenuSbar = { bg = p.surface },
  PmenuThumb = { bg = p.muted },
  WildMenu = { fg = p.white, bg = p.selection },
  QuickFixLine = { fg = p.yellow, bg = p.current_line },

  -- Base syntax
  Comment = { fg = p.muted },
  Constant = { fg = p.violet },
  String = { fg = p.pink },
  Character = { fg = p.yellow },
  Number = { fg = p.yellow },
  Boolean = { fg = p.cyan },
  Float = { fg = p.yellow },
  Identifier = { fg = p.foreground },
  Function = { fg = p.yellow },
  Statement = { fg = p.cyan },
  Conditional = { fg = p.cyan },
  Repeat = { fg = p.cyan },
  Label = { fg = p.yellow },
  Operator = { fg = p.cyan },
  Keyword = { fg = p.cyan },
  Exception = { fg = p.cyan },
  PreProc = { fg = p.cyan },
  Include = { fg = p.cyan },
  Define = { fg = p.cyan },
  Macro = { fg = p.green },
  PreCondit = { fg = p.cyan },
  Type = { fg = p.blue },
  StorageClass = { fg = p.orange },
  Structure = { fg = p.blue },
  Typedef = { fg = p.blue },
  Special = { fg = p.green },
  SpecialChar = { fg = p.cyan },
  Tag = { fg = p.blue },
  Delimiter = { fg = p.foreground },
  SpecialComment = { fg = p.muted },
  Debug = { fg = p.orange },
  Underlined = { fg = p.blue_accent, underline = true },
  Ignore = { fg = p.muted },
  Error = { fg = p.red },
  Todo = { fg = p.foreground, bg = "#204474", bold = true },

  -- Treesitter
  ["@comment"] = { fg = p.muted },
  ["@comment.documentation"] = { fg = p.muted },
  ["@comment.todo"] = { fg = p.foreground, bg = "#204474", bold = true },
  ["@comment.note"] = { fg = p.info, bold = true },
  ["@comment.warning"] = { fg = p.yellow, bold = true },
  ["@comment.error"] = { fg = p.red, bold = true },

  ["@variable"] = { fg = p.foreground },
  ["@variable.builtin"] = { fg = p.coral },
  ["@variable.parameter"] = { fg = p.foreground },
  ["@variable.parameter.builtin"] = { fg = p.coral },
  ["@variable.member"] = { fg = p.violet },
  ["@property"] = { fg = p.violet },
  ["@field"] = { fg = p.violet },

  ["@constant"] = { fg = p.violet },
  ["@constant.builtin"] = { fg = p.cyan },
  ["@constant.macro"] = { fg = p.violet },
  ["@number"] = { fg = p.yellow },
  ["@number.float"] = { fg = p.yellow },
  ["@boolean"] = { fg = p.cyan },

  ["@string"] = { fg = p.pink },
  ["@string.regexp"] = { fg = p.cyan },
  ["@string.escape"] = { fg = p.cyan },
  ["@string.special"] = { fg = p.yellow },
  ["@string.special.symbol"] = { fg = p.yellow },
  ["@string.special.url"] = { fg = p.pink, italic = true, underline = true },
  ["@character"] = { fg = p.yellow },
  ["@character.special"] = { fg = p.cyan },

  ["@function"] = { fg = p.yellow },
  ["@function.call"] = { fg = p.yellow },
  ["@function.builtin"] = { fg = p.green },
  ["@function.macro"] = { fg = p.green },
  ["@function.method"] = { fg = p.yellow },
  ["@function.method.call"] = { fg = p.yellow },
  ["@constructor"] = { fg = p.yellow },
  ["@attribute"] = { fg = p.green },
  ["@attribute.builtin"] = { fg = p.green },

  ["@type"] = { fg = p.blue },
  ["@type.builtin"] = { fg = p.cyan },
  ["@type.definition"] = { fg = p.blue },
  ["@type.qualifier"] = { fg = p.orange },

  ["@keyword"] = { fg = p.cyan },
  ["@keyword.function"] = { fg = p.cyan },
  ["@keyword.operator"] = { fg = p.cyan },
  ["@keyword.import"] = { fg = p.cyan },
  ["@keyword.storage"] = { fg = p.orange },
  ["@keyword.repeat"] = { fg = p.cyan },
  ["@keyword.return"] = { fg = p.cyan },
  ["@keyword.conditional"] = { fg = p.cyan },
  ["@keyword.exception"] = { fg = p.cyan },
  ["@keyword.directive"] = { fg = p.cyan },
  ["@keyword.directive.define"] = { fg = p.green },
  ["@keyword.coroutine"] = { fg = p.cyan },

  ["@operator"] = { fg = p.cyan },
  ["@punctuation.delimiter"] = { fg = p.foreground },
  ["@punctuation.bracket"] = { fg = p.foreground },
  ["@punctuation.special"] = { fg = p.foreground },

  ["@module"] = { fg = p.blue },
  ["@module.builtin"] = { fg = p.green },
  ["@namespace"] = { fg = p.blue },
  ["@label"] = { fg = p.yellow },

  ["@tag"] = { fg = p.blue },
  ["@tag.attribute"] = { fg = p.violet },
  ["@tag.delimiter"] = { fg = p.muted },

  -- Markup
  ["@markup.heading"] = { fg = p.cyan, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.raw"] = { fg = p.pink },
  ["@markup.raw.block"] = { fg = p.pink },
  ["@markup.link"] = { fg = p.cyan },
  ["@markup.link.label"] = { fg = p.purple },
  ["@markup.link.url"] = { fg = p.pink, italic = true, underline = true },
  ["@markup.list"] = { fg = p.cyan },
  ["@markup.quote"] = { fg = p.pink },
  ["@markup.math"] = { fg = p.yellow },

  ["@diff.plus"] = { fg = p.green_diff },
  ["@diff.minus"] = { fg = p.red_diff },
  ["@diff.delta"] = { fg = p.blue_accent },

  -- LSP semantic tokens
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.type"] = { link = "@type" },
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.interface"] = { link = "@type" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.typeParameter"] = { fg = p.blue_light },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.enumMember"] = { link = "@constant" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.macro"] = { link = "@function.macro" },
  ["@lsp.type.keyword"] = { link = "@keyword" },
  ["@lsp.type.comment"] = { link = "@comment" },
  ["@lsp.type.string"] = { link = "@string" },
  ["@lsp.type.number"] = { link = "@number" },
  ["@lsp.type.operator"] = { link = "@operator" },
  ["@lsp.type.decorator"] = { link = "@attribute" },

  -- Diagnostics
  DiagnosticError = { fg = p.red },
  DiagnosticWarn = { fg = p.yellow },
  DiagnosticInfo = { fg = p.info },
  DiagnosticHint = { fg = p.muted },
  DiagnosticOk = { fg = p.green_diff },
  DiagnosticVirtualTextError = { fg = p.red, bg = "#390813" },
  DiagnosticVirtualTextWarn = { fg = p.yellow, bg = "#3b2d16" },
  DiagnosticVirtualTextInfo = { fg = p.info, bg = "#28202d" },
  DiagnosticVirtualTextHint = { fg = p.muted, bg = p.current_line },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo = { undercurl = true, sp = p.info },
  DiagnosticUnderlineHint = { undercurl = true, sp = p.muted },
  DiagnosticUnnecessary = { fg = p.line_nr },
  DiagnosticDeprecated = { strikethrough = true },

  LspInlayHint = { fg = p.line_nr, bg = p.current_line },
  LspReferenceText = { bg = p.surface_high },
  LspReferenceRead = { bg = p.surface_high },
  LspReferenceWrite = { bg = p.surface_high },

  -- Vimdiff
  DiffAdd = { fg = p.green_diff, bg = diff.add },
  DiffChange = { bg = diff.change },
  DiffDelete = { fg = p.red_diff, bg = diff.delete },
  DiffText = { bg = diff.text },

  -- Spell
  SpellBad = { undercurl = true, sp = p.red },
  SpellCap = { undercurl = true, sp = p.yellow },
  SpellRare = { undercurl = true, sp = p.violet },
  SpellLocal = { undercurl = true, sp = p.blue },

  -- Gitsigns
  GitSignsAdd = { fg = p.green_diff },
  GitSignsChange = { fg = p.blue_accent },
  GitSignsDelete = { fg = p.red_diff },
  GitSignsTopdelete = { fg = p.red_diff },
  GitSignsChangedelete = { fg = p.orange },
  GitSignsUntracked = { fg = p.muted },

  -- Snacks picker
  SnacksNormal = { link = "NormalFloat" },
  SnacksWinBorder = { link = "FloatBorder" },
  SnacksPickerBorder = { link = "FloatBorder" },
  SnacksPickerTitle = { fg = p.cyan, bg = p.surface },
  SnacksPickerDir = { fg = p.muted },
  SnacksPickerFile = { fg = p.foreground },
  SnacksPickerMatch = { fg = p.yellow, bold = true },
  SnacksPickerPrompt = { fg = p.cyan },
  SnacksPickerCursorLine = { link = "CursorLine" },
  SnacksPickerToggle = { fg = p.white, bg = p.selection },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
