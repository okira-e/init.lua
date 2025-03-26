vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("V", "v", {})
vim.api.nvim_create_user_command("Vs", "vs", {})
vim.api.nvim_create_user_command("Reload", "e!", {})
vim.api.nvim_create_user_command("ReloadAll", "bufdo e!", {})

-- Lang=json
vim.api.nvim_create_user_command("Lang", function(opts)
    vim.cmd("set filetype " .. opts.args)
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
