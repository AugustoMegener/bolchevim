{ pkgs, ... }:
{

  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    nui-nvim
    nvim-web-devicons
  ];

  extraPackages = with pkgs; [
    git
  ];
}
