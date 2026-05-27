{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    barbecue-nvim
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
