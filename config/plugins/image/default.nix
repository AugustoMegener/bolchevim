{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    imagemagick
  ];

  plugins.image.enable = true;
}
