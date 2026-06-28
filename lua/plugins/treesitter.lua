-- Syntax highlighting + better indentation via Treesitter.
-- Pinned to the stable `master` branch (the `main` rewrite has a different API).
-- Parsers in `ensure_installed` are installed up front; anything else installs
-- automatically the first time you open that filetype (needs a C compiler).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "query", "bash",
        "c", "cpp", "rust", "go", "gomod", "gosum", "zig",
        "python",
        "typescript", "javascript", "tsx", "html", "css", "json", "jsonc",
        "yaml", "toml", "markdown", "markdown_inline",
        "nix", "dockerfile", "gitcommit", "gitignore", "diff",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Registering highlight above pulls in nvim-treesitter's query directives;
      -- require the module explicitly so they're present, then override the ones
      -- that crash on Neovim 0.11+. See lua/config/ts-injection-fix.lua.
      require("nvim-treesitter.query_predicates")
      require("config.ts-injection-fix").apply()
    end,
  },
}
