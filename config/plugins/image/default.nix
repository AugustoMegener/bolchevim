
{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    image-nvim
  ];


  extraPackages = with pkgs; [
    imagemagick
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}

