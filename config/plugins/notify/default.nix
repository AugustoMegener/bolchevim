{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-notify
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
