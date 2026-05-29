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
              return { { text = "", fg = "#2b2622", bg = "#302b24" } }
            end
          '';
          right = lib.nixvim.mkRaw ''
            function()
              return { { text = "", fg = "#2b2622", bg = "#302b24" } }
            end
          '';
        };
      };
      highlights = {
        fill = { bg = "#2b2622"; };
        background = { fg = "#866f51"; bg = "#2b2622"; };
        buffer_visible = { fg = "#866f51"; bg = "#2b2622"; };
        buffer_selected = { fg = "#da9a22"; bg = "#302b24"; bold = true; italic = false; };
        separator = { fg = "#383028"; bg = "#2b2622"; };
        separator_selected = { fg = "#383028"; bg = "#302b24"; };
        separator_visible = { fg = "#383028"; bg = "#2b2622"; };
        indicator_selected = { fg = "#da9a22"; bg = "#302b24"; underline = true; sp = "#da9a22"; };
        modified = { fg = "#da9a22"; bg = "#2b2622"; };
        modified_selected = { fg = "#da9a22"; bg = "#302b24"; };
        tab = { fg = "#866f51"; bg = "#2b2622"; };
        tab_selected = { fg = "#da9a22"; bg = "#302b24"; };
        tab_separator = { fg = "#383028"; bg = "#2b2622"; };
        tab_separator_selected = { fg = "#383028"; bg = "#302b24"; };
      };
    };
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}
