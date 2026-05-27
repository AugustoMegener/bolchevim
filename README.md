# Nixvim

Standalone Nixvim migrated from `~/.config/nixos/home/nvim`.

## Layout

- `flake.nix`: standalone Nixvim flake and pinned inputs
- `config/core`: shared options, keymaps, and the custom `primary` colorscheme
- `config/plugins/<name>`: one directory per plugin or plugin group

## Commands

```sh
nix run .
nix flake check
```

`nix flake check` currently passes on `x86_64-linux`.
