{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    image-nvim
  ];
}
