{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      parsers: with parsers; [
        vim
        lua
        regex
        bash
        c
        rust
        java
        kotlin
        javascript
        typescript
        css
        scss
        nix
        markdown
        markdown_inline
      ]
    ))
  ];
}
