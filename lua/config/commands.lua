-- Custom Ex commands (PascalCase, as required).

-- :Reload (alias :R) — re-read the current file from disk, discarding local
-- changes (== :e!).
local function reload()
  vim.cmd("edit!")
end

-- :ReloadAll (alias :RA) — re-read every open project file from disk, discarding
-- local changes. Reloads each buffer in its own context so windows/splits are
-- kept. Skips non-file buffers (terminals, help, unnamed) and files gone from disk.
local function reload_all()
  local reloaded, skipped = 0, 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" and name ~= "" then
      if vim.fn.filereadable(name) == 1 then
        local ok = pcall(vim.api.nvim_buf_call, buf, function() vim.cmd("edit!") end)
        reloaded = reloaded + (ok and 1 or 0)
        skipped = skipped + (ok and 0 or 1)
      else
        skipped = skipped + 1 -- deleted/unreadable on disk; leave the buffer as-is
      end
    end
  end
  vim.notify(("ReloadAll: %d reloaded, %d skipped"):format(reloaded, skipped))
end

-- :WriteAll (alias :WA) — save every modified project file (== :wall), and
-- report how many were written.
local function write_all()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified
      and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
      count = count + 1
    end
  end
  vim.cmd("silent! wall")
  vim.notify(("WriteAll: saved %d file(s)"):format(count))
end

vim.api.nvim_create_user_command("Reload", reload, { desc = "Reload current file from disk (discard changes)" })
vim.api.nvim_create_user_command("R", reload, { desc = "Alias for :Reload" })
vim.api.nvim_create_user_command("ReloadAll", reload_all, { desc = "Reload all open project files from disk (discard changes)" })
vim.api.nvim_create_user_command("RA", reload_all, { desc = "Alias for :ReloadAll" })
vim.api.nvim_create_user_command("WriteAll", write_all, { desc = "Save all modified project files" })
vim.api.nvim_create_user_command("WA", write_all, { desc = "Alias for :WriteAll" })

local last_stopped_lsp_names = {}

local function lsp_client_names()
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    names[#names + 1] = client.name
  end
  table.sort(names)
  return names
end

local function lsp_stop()
  local names = lsp_client_names()
  if vim.tbl_isempty(names) then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO)
    return
  end

  last_stopped_lsp_names = names
  vim.lsp.enable(names, false)
  vim.notify("Stopped LSP: " .. table.concat(names, ", "))
end

local function lsp_restart()
  local names = lsp_client_names()
  if vim.tbl_isempty(names) then
    names = last_stopped_lsp_names
  end
  if vim.tbl_isempty(names) then
    vim.notify("No LSP clients to restart", vim.log.levels.INFO)
    return
  end

  vim.lsp.enable(names, false)
  vim.defer_fn(function()
    vim.lsp.enable(names, true)
    vim.notify("Restarted LSP: " .. table.concat(names, ", "))
  end, 200)
end

vim.api.nvim_create_user_command("LspStop", lsp_stop, { desc = "Stop LSP clients attached to current buffer" })
vim.api.nvim_create_user_command("LspRestart", lsp_restart, { desc = "Restart LSP clients attached to current buffer" })

vim.api.nvim_create_user_command("Lang", function(opts)
  vim.bo.filetype = opts.args
  vim.notify("Filetype set to " .. opts.args)
end, {
  nargs = 1,
  complete = "filetype",
  desc = "Set current buffer filetype",
})

-- :YankDiagnostic — copy the diagnostic message(s) on the current line to the
-- clipboard (and unnamed register), e.g. to paste into a search. Helix's
-- yank-diagnostic equivalent.
vim.api.nvim_create_user_command("YankDiagnostic", function()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if vim.tbl_isempty(diags) then
    vim.notify("No diagnostic on this line", vim.log.levels.INFO)
    return
  end
  -- Most severe first (ERROR=1 .. HINT=4), so the meaningful one leads.
  table.sort(diags, function(a, b) return a.severity < b.severity end)
  local msgs = {}
  for _, d in ipairs(diags) do
    msgs[#msgs + 1] = d.message
  end
  local text = table.concat(msgs, "\n")
  vim.fn.setreg("+", text) -- system clipboard
  vim.fn.setreg('"', text) -- unnamed register (default paste)
  vim.notify(("Yanked %d diagnostic(s)"):format(#diags))
end, { desc = "Yank current-line diagnostic message(s) to clipboard" })
