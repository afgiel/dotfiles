# dotfiles

## Prerequisites

One of: [Homebrew](https://brew.sh), apt, dnf, or pacman

## Install

```sh
git clone git@github.com:andrewgiel/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## What it does

`setup.sh` installs dependencies and symlinks config files to the right places:

| File | Symlinked to |
|------|-------------|
| `vimrc` | `~/.vimrc` |
| `gitconfig` | `~/.gitconfig` |
| `tmux.conf` | `~/.tmux.conf` |
| `ghostty-config` | `~/Library/Application Support/com.mitchellh.ghostty/config` (macOS) or `~/.config/ghostty/config` (Linux) |

It also:

- Installs `ripgrep`, `fzf`, and `node` via Homebrew
- Installs [vim-plug](https://github.com/junegunn/vim-plug) and runs `:PlugInstall`
- Sets up [CoC](https://github.com/neoclide/coc.nvim) extensions (`coc-snippets`)

The script is idempotent -- safe to re-run at any time.

## Vim plugins

Managed by vim-plug. To add/remove plugins, edit `vimrc` and run `:PlugInstall` or `:PlugClean` in vim.

| Plugin | Purpose |
|--------|---------|
| [ALE](https://github.com/dense-analysis/ale) | Linting and fixing (eslint, flake8, prettier) |
| [fzf.vim](https://github.com/junegunn/fzf.vim) | Fuzzy file finder (`Ctrl+P`) |
| [coc.nvim](https://github.com/neoclide/coc.nvim) | Autocomplete and LSP (go-to-definition, hover, references) |
| [vim-elixir](https://github.com/elixir-editors/vim-elixir) | Elixir syntax highlighting |

## Key bindings (vim)

| Key | Action |
|-----|--------|
| `Ctrl+P` | Fuzzy file search |
| `gf` | Go to definition |
| `gd` | Go to definition (vsplit) |
| `gy` | Go to type definition |
| `gr` | Find references |
| `gh` | Hover docs |
| `gb` | Go back to previous buffer |
| `Ctrl+J` | Next ALE error |
| `Ctrl+K` | Previous ALE error |
| `Tab` / `Shift+Tab` | Navigate completion menu |
