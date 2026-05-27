{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    lualine-nvim
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
