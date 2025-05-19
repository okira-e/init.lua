-- plugins.lua - Plugin management and configuration

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
return require("lazy").setup({
    --
    -- Themes
    --

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    mason = true,
                    treesitter = true,
                },
            })
        end,
    },

    { -- Ayu
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.ayu_style = "dark"
            vim.g.ayu_transparent = 1
            vim.g.ayu_italic = 1
            vim.g.ayu_bold = 1
            vim.cmd.colorscheme "ayu"
        end,
    },

    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark')
        end,
    },

    -- Essential plugins
    { "nvim-lua/plenary.nvim" },

    -- Copilot
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            -- Disable by default
            vim.g.copilot_enabled = false

            -- Optional: suppress Copilot's tab mapping (to avoid conflict with cmp)
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true

            vim.keymap.set("n", "<leader>cp", function()
                vim.g.copilot_enabled = not vim.g.copilot_enabled
                print("Copilot " .. (vim.g.copilot_enabled and "enabled" or "disabled"))
            end, { desc = "Toggle Copilot" })

            vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', {silent = true, expr = true, script = true})
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {}, -- you don't need nvim-web-devicons if you're removing icons
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 60,
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                        },
                    },
                },
                filters = {
                    dotfiles = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
            })
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
        end,
    },

    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup {}
        end
    },

    -- Global search
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        "dist",
                        "build",
                        ".git/",
                        ".DS_Store",
                        "__pycache__",
                        "%.egg-info",
                        "%.egg-info/.*",
                        "%.egg-info/.*/*",
                        "target/",
                        "venv/",
                        "vendor/",
                    },
                    sorting_strategy = "ascending", -- puts newest match at top
                    layout_config = {
                        horizontal = {
                            width = 0.9,
                            preview_width = 0.55,
                            prompt_position = "top",
                        },
                    },
                    -- Close when I ESC
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-c>"] = actions.close, -- optional backup
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["q"] = actions.close, -- another fallback
                        },
                    },
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                require("telescope.builtin").find_files({
                    disable_devicons = true,
                    find_command = { "rg", "--files", "--hidden", "--no-ignore" },
                })
            end)
            vim.keymap.set("n", "<leader>b", builtin.buffers, {})
            vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>?", builtin.grep_string, {})
            vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>S", builtin.lsp_workspace_symbols, {})
            vim.keymap.set("n", "<leader>D", builtin.diagnostics, {})
        end,
    },

    -- Syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "html", "css", "bash", "python" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-l>",   -- start selection
                        node_incremental = "<C-l>", -- expand
                        node_decremental = "<C-h>", -- shrink
                        scope_incremental = "<C-k>", -- optional: jump to scope
                    },
                },
            })
        end,
    },

    -- LSP Support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "html", "cssls" },
                automatic_installation = true,
            })

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local telescope_builtin = require("telescope.builtin")

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                vim.api.nvim_create_user_command("Format", function()
                    vim.lsp.buf.format({ async = true })
                end, { desc = "Format current buffer with LSP" })

                -- Set <leader>l
                vim.keymap.set("n", "<leader>l", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,
            })
        end,
    },

    -- Cleaner hover info popup
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    hover = {
                        enabled = true,
                        silent = true,
                        opts = {
                            border = {
                                style = "rounded",
                                -- padding = { 1, 2 }, -- { vertical, horizontal }
                            },
                            position = {
                                row = 2,  -- ⬅️ this pushes it down by 1 line
                                col = 0,
                            },
                            win_options = {
                                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                            },
                        },
                    },
                    signature = {
                        enabled = false,
                        opts = {
                            border = {
                                style = "rounded",
                                padding = { 1, 2 },
                            },
                        },
                    },
                },
                presets = {
                    bottom_search = false,
                    command_palette = false,
                    long_message_to_split = true,
                    inc_rename = false,
                },
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    autocomplete = false, -- Disable auto completion popup
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },

    -- Comments
    {
        "numToStr/Comment.nvim",
        config = true,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            fmt = function(str)
                                -- Custom rename examples:
                                return ({
                                    NORMAL = "MOVE",
                                    INSERT = "BUGS",
                                    VISUAL = "YANK",
                                    ["V-LINE"] = "YANK",
                                    REPLACE = "OUTTAHERE",
                                    COMMAND = "$",
                                })[str] or str
                            end,
                        },
                    },
                    lualine_b = { 
                        {
                            "branch",
                            icons_enabled = false,
                        }
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,  -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = {
                        {
                            "",
                            icons_enabled = false,
                        }
                    },
                    lualine_y = {
                        "",
                        function()
                            return vim.fn.line("$") .. " total"
                        end,
                    },
                    lualine_z = { "location" } -- current line:col
                },
            })
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local opts = { buffer = bufnr, noremap = true, silent = true }

                    -- Jump to next/previous hunk
                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(gs.next_hunk)
                        return "<Ignore>"
                    end, vim.tbl_extend("force", opts, { expr = true }))

                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(gs.prev_hunk)
                        return "<Ignore>"
                    end, vim.tbl_extend("force", opts, { expr = true }))

                    -- Inline blame
                    vim.keymap.set("n", "<leader>g", gs.toggle_current_line_blame, opts)

                    -- Show the current git blame
                    vim.api.nvim_create_user_command("Blame", "Gitsigns blame_line", {})

                    vim.api.nvim_buf_create_user_command(bufnr, "Reset", function()
                        gs.reset_hunk()
                    end, { desc = "Reset current git hunk" })
                end,
            })
        end,
    },

    -- Multiple cursors
    {
        "mg979/vim-visual-multi",
        branch = "master", -- required if you're using lazy.nvim
        init = function()
            vim.g.VM_default_mappings = 0

            vim.g.VM_maps = {
                ["Find Under"]         = "<C-n>",
                ["Select All"]         = "<C-a>",
                ["Add Cursor Up"]      = "<C-k>",
                ["Add Cursor Down"]    = "<C-j>",
            }
        end
    },

    -- Terminal window inside of Neovim.
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                -- direction = "horizontal",
                -- size = function(term)
                --     if term.direction == "horizontal" then
                --         return 50
                --     elseif term.direction == "vertical" then
                --         return 80
                --     end
                -- end,
                open_mapping = [[<c-\>]],
                start_in_insert = true,
                persist_size = false,
            })

            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
        end,
    },

    -- Maximaize a split temporarily like in Zed.
    {
        "szw/vim-maximizer",
        keys = {
            { "<leader>m", "<cmd>MaximizerToggle<CR>", desc = "Toggle maximize split" },
        },
    },

    -- Jump to any symbol like in Helix.
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function()
            require("hop").setup()

            -- Map `gw` to word jump like Helix
            vim.keymap.set("n", "gw", function()
                require("hop").hint_words()
            end, { desc = "Hop to word" })
        end,
    }
})
