-- ~/.config/nvim/colors/zig_muted_inspired.lua
-- Zig Website Inspired (okira-e)
-- minimal, fast to iterate

if vim.g.colors_name then vim.cmd("hi clear") end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "zig_muted_inspired"

local P = {
  bg   = "#1C1C1D",
  fg   = "#cdd6f4",
  mute = "#9399b2",
  dim  = "#7f849c",
  -- accents (picked from your JSON)
  red    = "#f38ba8",
  yellow = "#F9E29F",
  green  = "#21DE54",
  cyan   = "#89dceb",
  blue   = "#74c7ec",
  violet = "#cbb0f7",
  mag    = "#b9c3fc",
  orange = "#F59545",
  white  = "#ffffff",
  line   = "#292A2D", -- active line bg
  sel    = "#3A3B46", -- selection
  border = "#313244",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Terminal (optional but nice)
vim.g.terminal_color_0  = "#2f3742"
vim.g.terminal_color_8  = "#656c76"
vim.g.terminal_color_1  = "#ff7b72"
vim.g.terminal_color_9  = "#ffa198"
vim.g.terminal_color_2  = "#3fb950"
vim.g.terminal_color_10 = "#56d364"
vim.g.terminal_color_3  = "#d29922"
vim.g.terminal_color_11 = "#e3b341"
vim.g.terminal_color_4  = "#58a6ff"
vim.g.terminal_color_12 = "#79c0ff"
vim.g.terminal_color_5  = "#be8fff"
vim.g.terminal_color_13 = "#d2a8ff"
vim.g.terminal_color_6  = "#39c5cf"
vim.g.terminal_color_14 = "#56d4dd"
vim.g.terminal_color_7  = "#f0f6fc"
vim.g.terminal_color_15 = "#ffffff"

-- Core UI
hi("Normal",        { fg=P.fg, bg=P.bg })
hi("NormalFloat",   { fg=P.fg, bg=P.bg })
hi("FloatBorder",   { fg=P.border, bg=P.bg })
hi("WinSeparator",  { fg=P.border, bg=P.bg })
hi("CursorLine",    { bg=P.line })
hi("CursorLineNr",  { fg=P.white, bold=true })
hi("LineNr",        { fg=P.dim })
hi("SignColumn",    { bg=P.bg })
hi("ColorColumn",   { bg=P.bg })
hi("Visual",        { fg="#000000", bg=P.red })
hi("Search",        { fg=P.bg, bg=P.red })
hi("IncSearch",     { fg=P.bg, bg=P.red, bold=true })
hi("CurSearch",     { fg=P.bg, bg="#EE5E86" })
hi("MatchParen",    { fg=P.red, bold=true, underline=true })
hi("Pmenu",         { fg=P.fg, bg="#0b0b11" })
hi("PmenuSel",      { fg=P.bg, bg=P.violet, bold=true })
hi("PmenuSbar",     { bg=P.border })
hi("PmenuThumb",    { bg=P.dim })
hi("VertSplit",     { fg=P.border })
hi("StatusLine",    { fg=P.fg, bg="#000000" })
hi("TabLine",       { fg=P.dim, bg="#000000" })
hi("TabLineSel",    { fg=P.fg, bg=P.bg, bold=true })
hi("Whitespace",    { fg=P.dim })

-- Syntax (Vim)
hi("Comment",       { fg=P.mute, italic=true })
hi("Constant",      { fg=P.red })
hi("String",        { fg=P.green })
hi("Character",     { fg=P.cyan })
hi("Number",        { fg=P.red })
hi("Boolean",       { fg=P.red })
hi("Float",         { fg=P.red })
hi("Identifier",    { fg=P.fg })
hi("Function",      { fg="#B1A0F8" }) -- from your function color
hi("Statement",     { fg=P.white })
hi("Operator",      { fg=P.cyan })
hi("Keyword",       { fg=P.white })
hi("PreProc",       { fg=P.orange })
hi("Type",          { fg=P.yellow })
hi("Special",       { fg=P.orange })
hi("Delimiter",     { fg=P.mute })
hi("Underlined",    { underline=true })
hi("Todo",          { fg=P.violet, bold=true })

-- Diagnostics
hi("DiagnosticError", { fg=P.red })
hi("DiagnosticWarn",  { fg=P.yellow })
hi("DiagnosticInfo",  { fg=P.cyan })
hi("DiagnosticHint",  { fg=P.dim })
hi("DiagnosticUnderlineError", { sp=P.red, undercurl=true })
hi("DiagnosticUnderlineWarn",  { sp=P.yellow, undercurl=true })
hi("DiagnosticUnderlineInfo",  { sp=P.cyan, undercurl=true })
hi("DiagnosticUnderlineHint",  { sp=P.dim, undercurl=true })

-- Git/Diff
hi("DiffAdd",    { fg=P.green })
hi("DiffChange", { fg=P.yellow })
hi("DiffDelete", { fg=P.red })
hi("DiffText",   { fg=P.blue, bold=true })
hi("GitSignsAdd",    { fg=P.green })
hi("GitSignsChange", { fg=P.yellow })
hi("GitSignsDelete", { fg=P.red })

-- Treesitter (minimal set; links keep it lean)
hi("@comment",        { link = "Comment" })
hi("@string",         { link = "String" })
hi("@number",         { link = "Number" })
hi("@boolean",        { link = "Boolean" })
hi("@constant",       { link = "Constant" })
hi("@variable",       { fg=P.fg })
hi("@variable.builtin", { fg=P.red })
hi("@field",          { fg="#b4befe" })
hi("@property",       { fg="#CCCCCC" })
hi("@function",       { link = "Function" })
hi("@function.builtin",{ fg=P.orange })
hi("@constructor",    { fg="#f2cdcd" })
hi("@parameter",      { fg="#CCCCCC" })
hi("@type",           { link = "Type" })
hi("@type.builtin",   { fg="#6688FF", italic=true })
hi("@keyword",        { link = "Keyword" })
hi("@operator",       { link = "Operator" })
hi("@tag",            { fg="#CCCCCC" })
hi("@tag.attribute",  { fg=P.yellow, italic=true })
hi("@punctuation",    { fg=P.mute })
