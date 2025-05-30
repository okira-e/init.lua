vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("QA", "qa", {})
vim.api.nvim_create_user_command("V", "v", {})
vim.api.nvim_create_user_command("Vs", "vs", {})
vim.api.nvim_create_user_command("VS", "vs", {})
vim.api.nvim_create_user_command("Reload", "e!", {})
vim.api.nvim_create_user_command("R", "e!", {})
vim.api.nvim_create_user_command("ReloadAll", "bufdo e!", {})
vim.api.nvim_create_user_command("Ra", "bufdo e!", {})
vim.api.nvim_create_user_command("Find", "NvimTreeFindFile", {})
vim.api.nvim_create_user_command("Indent", function(opts)
  local n = tonumber(opts.args)
  if not n then
    vim.api.nvim_err_writeln("Indent: invalid number of spaces")
    return
  end
  vim.opt.shiftwidth = n
  vim.opt.tabstop = n
  vim.opt.softtabstop = n
  vim.opt.expandtab = true
end, {
  nargs = 1,
})

vim.api.nvim_create_user_command("Reset", "Gitsigns reset_hunk", {
  nargs = 0,
  desc = "Reset the current hunk",
})
vim.api.nvim_create_user_command("Preview", "Gitsigns preview_hunk", {
  nargs = 0,
  desc = "Reset the current hunk",
})


-- Lang json
vim.api.nvim_create_user_command("Lang", function(opts)
  local ft = opts.args:gsub("^=", "") -- strip leading = if present
  vim.cmd("set filetype=" .. ft)
end, {
    nargs = 1,
    complete = "filetype",
    desc = "Manually set filetype",
  })


--
-- Autocmds
--

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove("r") -- Don't continue comments after Enter
        vim.opt_local.formatoptions:remove("o") -- Don't continue comments with o/O
        vim.opt_local.formatoptions:remove("c") -- Don't auto-wrap comments using textwidth
    end,
    desc = "Disable automatic comment continuation",
})
