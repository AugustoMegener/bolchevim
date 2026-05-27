{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    indent-blankline-nvim
    nvim-colorizer-lua
    auto-save-nvim
  ];

  plugins.auto-session = {
    enable = true;
    settings.pre_save_cmds = [ "lua pcall(MiniFiles.close)" ];
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}
