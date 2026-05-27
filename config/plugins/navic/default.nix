{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-navic
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
