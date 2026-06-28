-- Compatibility shim for nvim-treesitter (master branch) on Neovim 0.11+.
--
-- master is EOL and its injection directives assume the old query API where a
-- capture maps to a single TSNode. On 0.11+ a capture maps to a *list* of nodes,
-- and master's `all = false` request to keep the old shape is ignored, so the
-- handlers call `node:range()` on a table and crash. This breaks every markdown
-- code-fence injection — e.g. LSP hover docs that contain ```lang blocks.
--
-- We re-register the affected directives (force = true) with handlers that
-- normalize the list back to a single node. Faithful reimplementations of the
-- upstream logic; drop this file if/when we migrate to the `main` branch.
local M = {}

-- Mirror of upstream's get_parser_from_markdown_info_string.
local info_string_aliases = {
  ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
}
local function parser_from_info_string(alias)
  local match = vim.filetype.match({ filename = "a." .. alias })
  return match or info_string_aliases[alias] or alias
end

-- A capture is a TSNode (userdata) on old Neovim, a list of TSNodes on 0.11+.
local function single_node(match, id)
  local n = match[id]
  if type(n) == "table" then n = n[#n] end
  return n
end

function M.apply()
  local query = vim.treesitter.query
  local opts = { force = true, all = false }

  -- Picks the injected language from a markdown code fence's info string.
  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = single_node(match, pred[2])
    if not node then return end
    local alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = parser_from_info_string(alias)
  end, opts)

  -- Lowercases captured node text (used to make @injection.language case-insensitive).
  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = single_node(match, id)
    if not node then return end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then metadata[id] = {} end
    metadata[id].text = string.lower(text)
  end, opts)
end

return M
