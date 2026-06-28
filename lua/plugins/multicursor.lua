-- Multiple cursors via jake-stewart/multicursor.nvim — real cursors (extmark
-- backed) that run normal/visual/insert commands in lockstep. This is a
-- Sublime/VSCode-style model (cursor-first, "add next occurrence"), not Helix's
-- selection-first one; it's the closest thing that feels native.
--
-- Keys are all plain Ctrl chords, arrows, and leader maps — nothing that needs
-- the Kitty keyboard protocol, so they survive tmux. Conflict-checked against
-- the existing leader scope (s/S/a are taken), hence <leader>A for "all".
return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0", -- upstream's recommended stable branch
    -- Lazy-load on first use; lazy.nvim re-feeds the triggering key after the
    -- plugin (and these maps) are set up in config().
    keys = {
      -- Add cursor at the next match of the word/selection. C-g is a single
      -- control byte (0x07), so it's tmux-safe; it overrides only the niche
      -- show-file-info default. <leader>N still adds at the previous match.
      { "<C-g>", function() require("multicursor-nvim").matchAddCursor(1) end, mode = { "n", "x" }, desc = "MC: add cursor at next match" },
      -- Add a cursor on the line below / above. C-j and C-k are single control
      -- bytes (0x0A / 0x0B), so these work everywhere, tmux included.
      { "<C-j>", function() require("multicursor-nvim").lineAddCursor(1) end, mode = { "n", "x" }, desc = "MC: add cursor below" },
      { "<C-k>", function() require("multicursor-nvim").lineAddCursor(-1) end, mode = { "n", "x" }, desc = "MC: add cursor above" },
      -- Supporting actions on the leader scope (no conflicts; s/S/a are taken).
      { "<leader>N", function() require("multicursor-nvim").matchAddCursor(-1) end, mode = { "n", "x" }, desc = "MC: add cursor at prev match" },
      { "<leader>x", function() require("multicursor-nvim").matchSkipCursor(1) end, mode = { "n", "x" }, desc = "MC: skip to next match" },
      { "<leader>A", function() require("multicursor-nvim").matchAllAddCursors() end, mode = { "n", "x" }, desc = "MC: cursor on every match" },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      -- Keymaps that only exist while there are multiple cursors, so they can
      -- shadow normal mappings without stealing them the rest of the time.
      mc.addKeymapLayer(function(layer)
        layer({ "n", "x" }, "<Left>", mc.prevCursor, { desc = "MC: prev cursor" })
        layer({ "n", "x" }, "<Right>", mc.nextCursor, { desc = "MC: next cursor" })
        -- First <Esc> disables the extra cursors (so you can move freely); a
        -- second clears them entirely.
        layer("n", "<Esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end, { desc = "MC: disable / clear cursors" })
      end)

      -- Borrow the colorscheme's own groups so cursors match the ayu theme.
      local link = function(from, to) vim.api.nvim_set_hl(0, from, { link = to }) end
      link("MultiCursorCursor", "Cursor")
      link("MultiCursorVisual", "Visual")
      link("MultiCursorSign", "SignColumn")
      link("MultiCursorMatchPreview", "Search")
      link("MultiCursorDisabledCursor", "Visual")
      link("MultiCursorDisabledVisual", "Visual")
      link("MultiCursorDisabledSign", "SignColumn")
    end,
  },
}
