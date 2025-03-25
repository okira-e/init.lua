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
    -- Themes

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
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- Essential plugins
    { "nvim-lua/plenary.nvim" },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
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

    -- Global search
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                grep = {
                    prompt = "Grep❯ ",
                    input_prompt = "Grep For❯ ",
                    rg_opts = "--line-number --no-heading --color=always --smart-case -e",
                },
            })

            vim.keymap.set("n", "<leader>f", fzf.files, {})
            vim.keymap.set("n", "<leader>b", fzf.buffers, {})
            vim.keymap.set("n", "<leader>/", fzf.live_grep_native)
            vim.keymap.set("n", "<leader>?", fzf.grep_cword) -- grep for word under cursor
            vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols)
            vim.keymap.set("n", "<leader>S", fzf.lsp_workspace_symbols)
        end,
    },

    -- Better syntax highlighting and parsing
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
                ensure_installed = { "lua_ls", "tsserver", "pyright", "html", "cssls" },
                automatic_installation = true,
            })

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local fzf = require("fzf-lua")

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", fzf.lsp_references, opts)
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                vim.notify("LSP attached: " .. client.name)
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

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")

            toggleterm.setup({
                open_mapping = [[<C-\>]],
                direction = "float",
                float_opts = {
                    border = "curved",
                    width = 100,
                    height = 30,
                    winblend = 3,
                },
                start_in_insert = true,
                persist_size = false,
            })

            -- -- Use manual keymap
            -- vim.keymap.set("n", "<leader>j", function()
            --     toggleterm.toggle(1)
            -- end, { noremap = true, silent = true })
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
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
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
                                    REPLACE = "OUTTAHERE",
                                    COMMAND = "$",
                                })[str] or str
                            end,
                        },
                    },
                    lualine_b = { "branch" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
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
                ["Find Under"]         = "<C-n>",   -- Select next
                ["Select All"]         = "<C-a>",   -- Select all
                ["Add Cursor Up"]      = "<C-k>",   -- Alt+k for up
                ["Add Cursor Down"]    = "<C-j>",   -- Alt+j for down
            }
        end
    },


    -- Terminal integration
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                direction = "float",
            })
        end,
    },
})
