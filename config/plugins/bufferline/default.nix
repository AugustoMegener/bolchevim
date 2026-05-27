{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    bufferline-nvim
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
