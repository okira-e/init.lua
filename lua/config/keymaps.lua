-- Global, plugin-independent keymaps. LSP and git mappings live next to their
-- plugins (set on attach) so they only exist where they make sense.
local map = vim.keymap.set

-- Save the current buffer. Saving is always explicit — nothing auto-saves.
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save buffer" })

-- Format the current file. On-demand only; nothing formats on save.
--
-- JS/TS (and JSX/TSX) plus Markdown go through Prettier so the project's
-- .prettierrc is honored. Everything else uses the attached LSP, which does
-- nothing if no server provides formatting.
local PRETTIER_FT = {
  javascript = true, javascriptreact = true,
  typescript = true, typescriptreact = true,
  markdown = true, markdown_mdx = true,
}

-- Resolve Prettier: prefer the project-local node_modules/.bin/prettier so the
-- exact pinned version + plugins are used; fall back to a global one.
local function prettier_cmd()
  local root = vim.fs.root(0, "node_modules")
  local local_bin = root and (root .. "/node_modules/.bin/prettier")
  if local_bin and vim.fn.executable(local_bin) == 1 then return local_bin end
  if vim.fn.executable("prettier") == 1 then return "prettier" end
  return nil
end

local function format_prettier()
  local cmd = prettier_cmd()
  if not cmd then
    vim.notify("prettier not found (install it in the project or globally)", vim.log.levels.WARN)
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
  -- --stdin-filepath lets Prettier pick the right parser and locate .prettierrc.
  vim.system(
    { cmd, "--stdin-filepath", vim.api.nvim_buf_get_name(buf) },
    { stdin = input },
    vim.schedule_wrap(function(out)
      if out.code ~= 0 then
        vim.notify("prettier failed:\n" .. (out.stderr or ""), vim.log.levels.ERROR)
        return
      end
      if not vim.api.nvim_buf_is_valid(buf) then return end
      local lines = vim.split(out.stdout, "\n")
      if lines[#lines] == "" then lines[#lines] = nil end -- drop trailing newline
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.fn.winrestview(view)
    end)
  )
end

map("n", "<leader>l", function()
  if PRETTIER_FT[vim.bo.filetype] then
    format_prettier()
  else
    vim.lsp.buf.format({ async = true })
  end
end, { desc = "Format file" })

-- Yank the visual selection explicitly to the system clipboard.
map("x", "Y", '"+y', { desc = "Yank selection to system clipboard" })

-- Incremental selection: grow/shrink along Treesitter syntax nodes. LSP
-- selectionRange is only a fallback: some servers start at whole statements,
-- while Treesitter can usually begin at the expression under the cursor.
local function lsp_has_selection_range()
  return #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/selectionRange" }) > 0
end

local function lsp_selection_range(direction)
  if lsp_has_selection_range() then
    vim.lsp.buf.selection_range(direction)
    return true
  end
  return false
end

local function incremental_select(direction)
  local ok, sel = pcall(require, "nvim-treesitter.incremental_selection")
  if ok then
    local mode = vim.fn.mode()
    local fn = direction > 0
      and (mode:match("^n") and sel.init_selection or sel.node_incremental)
      or sel.node_decremental
    ok = pcall(fn)
    if ok then return end
  end

  if not lsp_selection_range(direction) then
    vim.notify("No selection-range source for this buffer (LSP or Treesitter)", vim.log.levels.WARN)
  end
end

map({ "n", "x" }, "<C-l>", function() incremental_select(1) end, { desc = "Expand selection" })
map({ "n", "x" }, "<C-h>", function() incremental_select(-1) end, { desc = "Shrink selection" })

-- Clear search highlight on Esc.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Make n/N direction-stable like Helix: n is always the next match (forward),
-- N always the previous — even after a backward search (#, ?). Vim normally
-- repeats in the last search's direction, which flips n/N after #. v:searchforward
-- is 1 after a forward search, 0 after backward; when it's 0 we swap the keys so
-- the on-screen direction stays constant. (zv opens any fold at the match.)
map("n", "n", "'Nn'[v:searchforward] .. 'zv'", { expr = true, desc = "Next match" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next match" })
map("n", "N", "'nN'[v:searchforward] .. 'zv'", { expr = true, desc = "Prev match" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev match" })

-- Move by visual lines when wrapping (so j/k don't skip wrapped segments).
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Diagnostics: jump between them. Current-line diagnostics appear in the
-- top-right float configured with the LSP.
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
