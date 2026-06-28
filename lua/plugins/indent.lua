-- Smart per-buffer indentation detection. On opening a file, guess-indent
-- inspects its existing indentation and sets expandtab/shiftwidth/tabstop to
-- match the project. If a file uses spaces, it switches to spaces at the
-- detected width; if it uses tabs, it keeps real tabs. When nothing can be
-- detected (new/empty file), the defaults in config/options.lua stand:
-- real tabs, 4 wide.
return {
  {
    "NMAC427/guess-indent.nvim",
    -- Not lazy-loaded on BufReadPost: that event has already fired for a file
    -- opened via `nvim <file>` by the time the plugin's autocmd would register,
    -- so the very first buffer would be missed. Loading at startup (the plugin
    -- is tiny) guarantees its autocmd exists before any buffer is read.
    lazy = false,
    opts = {
      -- Keep our tab-width-4 default for tab-indented files rather than
      -- forcing tabstop to something else.
      on_tab_options = { expandtab = false },
      on_space_options = {
        expandtab = true,
        tabstop = "detected",
        softtabstop = "detected",
        shiftwidth = "detected",
      },
    },
  },
}
