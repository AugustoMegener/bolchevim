{ pkgs, lib, ... }:
{
  plugins.barbecue = {
    enable = true;
    settings = {
      theme = lib.nixvim.mkRaw ''
        {
          normal = { fg = "#a08060", },
          ellipsis = { fg = "#57473a", },
          separator = { fg = "#57473a", },
          modified = { fg = "#da9a22", },
          dirname = { fg = "#a08060", },
          basename = { bold = true, },
          context = {},
        }
      '';
    };
  };
}
