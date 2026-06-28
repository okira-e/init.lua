-- Bootstrap lazy.nvim (the plugin manager) and load everything under lua/plugins/.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  -- Auto-check for plugin updates in the background, but don't nag.
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  -- Disable some built-in plugins we don't use; keeps startup lean.
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tutor", "zipPlugin" },
    },
  },
})
