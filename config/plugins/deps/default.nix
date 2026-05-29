{ pkgs, ... }:
{

  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    nui-nvim
    nvim-web-devicons
  ];

  plugins.web-devicons.enable = true;

  extraPackages = with pkgs; [
    git
  ];
}
