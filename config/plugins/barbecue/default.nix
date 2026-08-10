{ pkgs, lib, ... }:
{
  plugins.barbecue = {
    enable = true;
    settings = {
      theme = lib.nixvim.mkRaw ''
        {
          normal = { fg = "#866f50", },
          ellipsis = { fg = "#57473a", },
          separator = { fg = "#57473a", },
          modified = { fg = "#da9a22", },
          dirname = { fg = "#866f50", },
          basename = { bold = true, },
          context = {},
        }
      '';
    };
  };
}
