{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    trouble-nvim
  ];

  extraConfigLua = ''
    require("trouble").setup()
  '';
}
