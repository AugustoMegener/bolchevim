{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    bufferline-nvim
  ];

  plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        mode = "buffers";
        separator_style = [ "|" "|" ];
        indicator = { style = "underline"; };
        show_buffer_close_icons = false;
        show_close_icon = false;
        left_trunc_marker = "󰇘";
        right_trunc_marker = "󰇘";
        modified_icon = "";
        offsets = {};
        color_icons = true;
        get_element_icon = lib.nixvim.mkRaw ''
          function(element)
            local icon = require("nvim-web-devicons").get_icon(
                element.path,
                element.extension,
                { default = true }
            )
            return icon, nil
          end
        '';
        custom_areas = {
          left = lib.nixvim.mkRaw ''
            function()
              return { { text = "", fg = "#26211c", bg = "#2e261f" } }
            end
          '';
          right = lib.nixvim.mkRaw ''
            function()
              return { { text = "", fg = "#26211c", bg = "#2e261f" } }
            end
          '';
        };
      };
      highlights = {
        fill = { bg = "#26211c"; };
        background = { fg = "#866f51"; bg = "#26211c"; };
        buffer_visible = { fg = "#866f51"; bg = "#26211c"; };
        buffer_selected = { fg = "#da9a22"; bg = "#2e261f"; bold = true; italic = false; };
        separator = { fg = "#383028"; bg = "#26211c"; };
        separator_selected = { fg = "#383028"; bg = "#2e261f"; };
        separator_visible = { fg = "#383028"; bg = "#26211c"; };
        indicator_selected = { fg = "#da9a22"; bg = "#2e261f"; underline = true; sp = "#da9a22"; };
        modified = { fg = "#da9a22"; bg = "#26211c"; };
        modified_selected = { fg = "#da9a22"; bg = "#2e261f"; };
        tab = { fg = "#866f51"; bg = "#26211c"; };
        tab_selected = { fg = "#da9a22"; bg = "#2e261f"; };
        tab_separator = { fg = "#383028"; bg = "#26211c"; };
        tab_separator_selected = { fg = "#383028"; bg = "#2e261f"; };
      };
    };
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}
