-- LSP: language servers managed by mason, auto-enabled via mason-lspconfig,
-- with native (no-plugin) completion turned on per buffer.
--
-- To add a language later: add its server name to `servers` below. mason will
-- install it and it'll be enabled automatically. Per-server settings (if any)
-- go in the `settings` table.
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", build = ":MasonUpdate", opts = {} },
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Servers to install + enable. lspconfig names.
      local servers = {
        "lua_ls",       -- Lua (this config)
        "ts_ls",        -- TypeScript / JavaScript
        "html",
        "cssls",
        "jsonls",
        "rust_analyzer",
        "gopls",
        "clangd",       -- C / C++
        "zls",          -- Zig
        "ols",          -- Odin
        "pyright",      -- Python types
        "ruff",         -- Python lint/format
        "bashls",       -- Bash / shell
        "yamlls",
        "taplo",        -- TOML
        "marksman",     -- Markdown
        -- "nil_ls",    -- Nix: re-enable once `nix` is installed (it builds from source against it).
      }

      -- Per-server overrides. Defaults come from nvim-lspconfig's shipped configs.
      local settings = {
        lua_ls = {
          settings = {
            Lua = {
              -- We're editing a Neovim config, so teach lua_ls about `vim`
              -- and the runtime instead of warning about them.
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
      }
      for name, cfg in pairs(settings) do
        vim.lsp.config(name, cfg)
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      -- Diagnostics presentation. Keep signs/underlines, but do not use
      -- virtual_lines: they add screen rows while moving across diagnostics.
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
        underline = true,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
          },
        },
        float = { border = "rounded", source = true },
      })

      local diagnostic_float_win
      local diagnostic_float_buf

      local function close_diagnostic_float()
        if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
          vim.api.nvim_win_close(diagnostic_float_win, true)
        end
        diagnostic_float_win = nil
        diagnostic_float_buf = nil
      end

      local function diagnostic_label(severity)
        local labels = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN] = "W",
          [vim.diagnostic.severity.INFO] = "I",
          [vim.diagnostic.severity.HINT] = "H",
        }
        return labels[severity] or "?"
      end

      local function show_line_diagnostics()
        if vim.api.nvim_get_mode().mode:match("^i") then
          close_diagnostic_float()
          return
        end

        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if vim.tbl_isempty(diagnostics) then
          close_diagnostic_float()
          return
        end

        table.sort(diagnostics, function(a, b)
          return (a.severity or vim.diagnostic.severity.HINT) < (b.severity or vim.diagnostic.severity.HINT)
        end)

        local lines = {}
        for _, diagnostic in ipairs(diagnostics) do
          local source = diagnostic.source and ("[" .. diagnostic.source .. "] ") or ""
          local message = diagnostic.message:gsub("\n", " ")
          lines[#lines + 1] = diagnostic_label(diagnostic.severity) .. " " .. source .. message
        end

        local max_width = math.max(20, math.min(90, vim.o.columns - 4))
        local width = 1
        for _, line in ipairs(lines) do
          width = math.max(width, math.min(max_width, vim.fn.strdisplaywidth(line)))
        end

        close_diagnostic_float()
        diagnostic_float_buf = vim.api.nvim_create_buf(false, true)
        vim.bo[diagnostic_float_buf].bufhidden = "wipe"
        vim.api.nvim_buf_set_lines(diagnostic_float_buf, 0, -1, false, lines)

        diagnostic_float_win = vim.api.nvim_open_win(diagnostic_float_buf, false, {
          relative = "editor",
          anchor = "NE",
          row = 1,
          col = vim.o.columns - 1,
          width = width,
          height = #lines,
          border = "rounded",
          style = "minimal",
          focusable = false,
          zindex = 60,
        })
      end

      vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "DiagnosticChanged", "WinResized" }, {
        group = vim.api.nvim_create_augroup("TopRightLineDiagnostics", { clear = true }),
        callback = vim.schedule_wrap(show_line_diagnostics),
        desc = "Show current-line diagnostics in a top-right float",
      })
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("CloseTopRightLineDiagnostics", { clear = true }),
        callback = close_diagnostic_float,
        desc = "Hide current-line diagnostic float in insert mode",
      })

      -- Buffer-local LSP keymaps + native completion, set when a server attaches.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local function map(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
          end

          -- Hover, sized for readability: wrap long lines and cap the width so
          -- signatures don't sprawl across the screen. Border comes from
          -- 'winborder'. Call again (K/<leader>k) to focus and scroll it.
          local function hover()
            vim.lsp.buf.hover({ max_width = 80, max_height = 20, wrap = true })
          end
          map("K", hover, "Hover docs")
          map("<leader>k", hover, "Hover docs")
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          -- References in a snacks picker (fuzzy + preview), matching the look
          -- of the <leader>s symbol pickers, instead of the quickfix split.
          map("gr", function() Snacks.picker.lsp_references() end, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("gy", vim.lsp.buf.type_definition, "Type definition")
          map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>a", vim.lsp.buf.code_action, "Code action")

          -- Built-in completion, manual-only: the menu never pops up on its own
          -- (no autotrigger on typing or on trigger chars like `.`). Press
          -- <C-Space> to summon it. No completion plugin needed.
          if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
            -- <C-Space> often arrives as <C-@>/<Nul> in terminals — map both.
            vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = ev.buf, desc = "Trigger completion" })
            vim.keymap.set("i", "<C-@>", vim.lsp.completion.get, { buffer = ev.buf, desc = "Trigger completion" })
            vim.keymap.set("i", "<CR>", function()
              return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
            end, { buffer = ev.buf, expr = true, desc = "Confirm completion or newline" })
          end
        end,
      })
    end,
  },
}
