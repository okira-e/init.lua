-- Colorschemes. The active theme is the custom `ayu` colorscheme defined in
-- colors/ayu.lua (no plugin) and applied from init.lua. Catppuccin stays
-- installed as a switchable fallback: `:colorscheme catppuccin`.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      integrations = {
        gitsigns = true,
        treesitter = true,
        native_lsp = { enabled = true },
      },
    },
  },
}
