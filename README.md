# Helix-like Nvim Config

Leader is `Space`.

## Core

| Key                | Action                                         |
| ------------------ | ---------------------------------------------- |
| `<leader>w`        | Save current buffer                            |
| `<leader>l`        | Format file                                    |
| `<C-q>`            | Close buffer, keep window open                 |
| `Y` in visual mode | Yank selection to system clipboard             |
| `<Esc>`            | Clear search highlight                         |
| `j` / `k`          | Move by visual lines when lines wrap           |
| `n` / `N`          | Next / previous search match, direction-stable |
| `<C-l>`            | Expand Treesitter/LSP selection                |
| `<C-h>`            | Shrink Treesitter/LSP selection                |

## Pickers

| Key         | Action                                    |
| ----------- | ----------------------------------------- |
| `<leader>f` | Find files                                |
| `<leader>b` | Buffers                                   |
| `<leader>g` | Git changed files                         |
| `<leader>/` | Global search                             |
| `<leader>t` | Search `nocheckin` markers                |
| `<leader>s` | Document symbols                          |
| `<leader>S` | Workspace symbols                         |
| `<leader>d` | Diagnostics in current file               |
| `<leader>D` | Diagnostics in project                    |
| `<leader>e` | File explorer at project root             |
| `<leader>E` | File explorer at current buffer directory |

Picker input:

| Key                                 | Action                                     |
| ----------------------------------- | ------------------------------------------ |
| `<Esc>`                             | Close picker                               |
| `<Up>` / `<C-p>` in global search   | Restore previous query when input is empty |
| `<C-Left>` / `<M-Left>` / `<M-b>`   | Move one word left                         |
| `<C-Right>` / `<M-Right>` / `<M-f>` | Move one word right                        |

Search is fixed-string by default, not regex. It is case-insensitive until the query contains an uppercase character.

## LSP

| Key                                  | Action                     |
| ------------------------------------ | -------------------------- |
| `K`                                  | Hover docs                 |
| `<leader>k`                          | Hover docs                 |
| `gd`                                 | Go to definition           |
| `gD`                                 | Go to declaration          |
| `gr`                                 | References picker          |
| `gi`                                 | Go to implementation       |
| `gy`                                 | Go to type definition      |
| `<leader>r`                          | Rename symbol              |
| `<leader>a`                          | Code action                |
| `<C-Space>` / `<C-@>` in insert mode | Trigger completion         |
| `<CR>` with completion menu open     | Accept selected completion |
| `[d` / `]d`                          | Previous / next diagnostic |

Current-line diagnostics show in a top-right float instead of virtual lines.

## Git

| Key / Command               | Action                           |
| --------------------------- | -------------------------------- |
| `]c` / `[c`                 | Next / previous git hunk         |
| `<leader>hp`                | Preview hunk                     |
| `<leader>hs`                | Stage hunk                       |
| `<leader>hr`                | Reset hunk                       |
| `<leader>hr` in visual mode | Reset selected hunks             |
| `<leader>hb`                | Show full blame for current line |
| `:Blame`                    | Toggle inline git blame          |
| `:Log`                      | Git log picker with diff preview |

## Multicursor

| Key                                              | Action                       |
| ------------------------------------------------ | ---------------------------- |
| `<C-g>`                                          | Add cursor at next match     |
| `<leader>N`                                      | Add cursor at previous match |
| `<leader>x`                                      | Skip next match              |
| `<leader>A`                                      | Add cursor at every match    |
| `<C-j>`                                          | Add cursor on line below     |
| `<C-k>`                                          | Add cursor on line above     |
| `<Left>` / `<Right>` while multicursor is active | Previous / next cursor       |
| `<Esc>` while multicursor is active              | Disable or clear cursors     |

## Commands

| Command              | Action                                                          |
| -------------------- | --------------------------------------------------------------- |
| `:Reload` / `:R`     | Reload current file from disk, discarding local changes         |
| `:ReloadAll` / `:RA` | Reload all open project files from disk                         |
| `:WriteAll` / `:WA`  | Save all modified project files                                 |
| `:LspStop`           | Stop LSP clients attached to current buffer                     |
| `:LspRestart`        | Restart LSP clients attached to current buffer                  |
| `:Lang <filetype>`   | Set current buffer filetype                                     |
| `:YankDiagnostic`    | Copy current-line diagnostics to clipboard and unnamed register |

## Built-In Behavior Notes

| Behavior             | Note                                                                 |
| -------------------- | -------------------------------------------------------------------- |
| `:e path/`           | Shows file suggestions automatically for edit paths                  |
| Comment continuation | Disabled for `o`, `O`, and new lines                                 |
| Clipboard            | Normal yanks stay inside Neovim; use visual `Y` for system clipboard |
| Markdown formatting  | Uses Prettier when available                                         |
