{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    firenvim
  ];
}
