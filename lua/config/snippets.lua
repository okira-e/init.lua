-- Minimal snippet expansion: no plugin, just VSCode-style JSON files under
-- snippets/ (manifest in package.json maps filetypes -> files, so e.g. js/jsx/
-- ts/tsx can share one file) read directly and expanded via native
-- vim.snippet. <Tab> expands a matching prefix or jumps to the next tabstop;
-- <S-Tab> jumps back. Falls through to a literal Tab when neither applies.
local snippets_dir = vim.fn.stdpath("config") .. "/snippets"

-- filetype -> resolved file path, built once from package.json.
local filetype_to_file = {}
do
  local manifest_path = snippets_dir .. "/package.json"
  local f = io.open(manifest_path, "r")
  if f then
    local ok, manifest = pcall(vim.json.decode, f:read("*a"))
    f:close()
    if ok and manifest.contributes and manifest.contributes.snippets then
      for _, entry in ipairs(manifest.contributes.snippets) do
        local path = snippets_dir .. "/" .. entry.path:gsub("^%./", "")
        for _, lang in ipairs(entry.language or {}) do
          filetype_to_file[lang] = path
        end
      end
    end
  end
end

-- Resolved file path -> decoded snippet table, loaded lazily and cached.
local file_cache = {}
local function load_file(path)
  if file_cache[path] then return file_cache[path] end
  local f = io.open(path, "r")
  if not f then
    file_cache[path] = {}
    return file_cache[path]
  end
  local ok, data = pcall(vim.json.decode, f:read("*a"))
  f:close()
  file_cache[path] = ok and data or {}
  return file_cache[path]
end

local function snippets_for_current_buffer()
  local path = filetype_to_file[vim.bo.filetype]
  return path and load_file(path) or nil
end

-- Finds the snippet whose prefix ends the text before the cursor.
local function match_prefix()
  local snippets = snippets_for_current_buffer()
  if not snippets then return nil end
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(1, col)
  for _, snippet in pairs(snippets) do
    local prefix = snippet.prefix
    if before:sub(-#prefix) == prefix then
      return prefix, snippet
    end
  end
  return nil
end

local function expand_or_jump()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
    return
  end

  local prefix, snippet = match_prefix()
  if not snippet then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col - #prefix, row - 1, col, {})
  local body = type(snippet.body) == "table" and table.concat(snippet.body, "\n") or snippet.body
  vim.snippet.expand(body)
end

local function jump_back()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end

vim.keymap.set("i", "<Tab>", expand_or_jump, { desc = "Expand snippet / jump forward" })
vim.keymap.set("i", "<S-Tab>", jump_back, { desc = "Jump to previous snippet tabstop" })
