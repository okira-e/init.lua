-- Smart per-buffer indentation detection. On opening a file, guess-indent
-- inspects its existing indentation and sets expandtab/shiftwidth/tabstop to
-- match the project. Space-indented files use their detected width. Go, Odin,
-- and Masa are excluded because config/options.lua deliberately enforces tabs
-- for them; every other filetype keeps space insertion enabled.
return {
  {
    "NMAC427/guess-indent.nvim",
    -- Not lazy-loaded on BufReadPost: that event has already fired for a file
    -- opened via `nvim <file>` by the time the plugin's autocmd would register,
    -- so the very first buffer would be missed. Loading at startup (the plugin
    -- is tiny) guarantees its autocmd exists before any buffer is read.
    lazy = false,
    opts = {
      filetype_exclude = { "netrw", "tutor", "go", "odin", "masa" },
      -- Existing literal tabs outside the excluded languages do not change the
      -- editing policy: newly inserted indentation still uses spaces.
      on_tab_options = { expandtab = true },
      on_space_options = {
        expandtab = true,
        tabstop = "detected",
        softtabstop = "detected",
        shiftwidth = "detected",
      },
    },
  },
}
