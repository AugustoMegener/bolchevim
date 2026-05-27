{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-lint
  ];

  extraPackages = with pkgs; [
    ktlint
    eslint_d
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
