-- Fuzzy pickers + a left sidebar file tree via snacks.picker. Pure-Lua matcher
-- (no fzf/fd binary needed); uses ripgrep for grep/files when available.

-- Project root = nearest ancestor with a VCS/marker file, else the cwd.
local function project_root()
  local markers = { ".git", ".hg", ".svn", "Cargo.toml", "go.mod", "package.json", "pyproject.toml" }
  return vim.fs.root(vim.api.nvim_buf_get_name(0), markers) or vim.uv.cwd()
end

-- Remembers the last global-search query so reopening re-applies it (Zed/Helix
-- style). Seeded into the grep input on open; captured on close. Older queries
-- are still reachable with <C-Up>/<C-Down> (snacks input history).
local last_grep = ""
local function global_search()
  Snacks.picker.grep({
    search = last_grep,
    on_close = function(picker)
      local q = picker.input and picker.input.filter and picker.input.filter.search
      if q and q ~= "" then last_grep = q end
    end,
  })
end

return {
  {
    "folke/snacks.nvim",
    -- Load on first picker keypress; the `Snacks` global is ready by then.
    keys = {
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>g", function() Snacks.picker.git_status() end, desc = "Git changed files" },
      { "<leader>/", global_search, desc = "Global search (grep)" },
      { "<leader>t", function() Snacks.picker.grep({ search = "nocheckin" }) end, desc = "Find nocheckin markers" },
      { "<leader>s", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
      { "<leader>S", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
      { "<leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (file)" },
      { "<leader>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
      -- Left sidebar file tree (snacks explorer, native sidebar layout). Type to
      -- filter the tree; <CR> opens/expands. e = project root, E = buffer dir.
      { "<leader>e", function() Snacks.picker.explorer({ cwd = project_root() }) end, desc = "Explorer (project root)" },
      { "<leader>E", function() Snacks.picker.explorer({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Explorer (buffer dir)" },
      -- Close the buffer but keep the window/split (snacks swaps in another buffer first).
      { "<C-q>", function() Snacks.bufdelete() end, mode = { "n" }, desc = "Close buffer (keep window)" },
    },
    opts = {
      picker = {
        icons = {
          files = { enabled = false },
        },
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
        },
        win = {
          input = {
            keys = {
              -- One Esc closes the picker. By default Esc only leaves insert
              -- mode (input -> normal), so it took two presses to close.
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
    },
  },
}
