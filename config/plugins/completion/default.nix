{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    luasnip
    cmp_luasnip
    nvim-autopairs
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
