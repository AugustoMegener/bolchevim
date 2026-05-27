{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    telescope-nvim
      #neo-tree-nvim
  ];

  extraPackages = with pkgs; [
    fd
      ripgrep
  ];

  plugins.mini = {
    enable = true;
    modules = {
      files = {
        options = {
          permanent_delete = true;
          use_as_default_explorer = true;
        };
      };
    };
  };

  plugins.oil = {
    enable = false;

    settings = {
      default_file_explorer = true;
      columns = [
        "icon"
        "permissions"
        "size"
        "mtime"
      ];

      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;

      lsp_file_methods = {
        enabled = true;
        timeout_ms = 100;
        autosave_changes = true;
      };
      constrain_cursor = "editable";
      watch_for_changes = false;
#       keymaps = {
#         "g?" = { action = "actions.show_help"; mode = "n"; };
#         "<CR>" = { action = "actions.select"; };
#         "<C-s>" = { action = "actions.select"; opts.vertical = true; };
#         "<C-h>" = { action = "actions.select"; opts.horizontal = true; };
#         "<C-t>" = { action = "actions.select"; opts.tab = true; };
#         "<C-p>" = { action = "actions.preview"; };
#         "<C-c>" = { action = "actions.close"; mode = "n"; };
#         "<C-l>" = { action = "actions.refresh"; };
#         "-" = { action = "actions.parent"; mode = "n"; };
#         "_" = { action = "actions.open_cwd"; mode = "n"; };
#         "`" = { action = "actions.cd"; mode = "n"; };
#         "g~" = { action = "actions.cd"; opts.scope = "tab"; mode = "n"; };
#         "gs" = { action = "actions.change_sort"; mode = "n"; };
#         "gx" = { action = "actions.open_external"; };
#         "g." = { action = "actions.toggle_hidden"; mode = "n"; };
#         "g\\" = { action = "actions.toggle_trash"; mode = "n"; };
#       };
#       use_default_keymaps = true;

      view_options = {
        show_hidden = false;
        natural_order = "fast";
        case_insensitive = false;
        sort = [
          [ "type" "asc" ]
            [ "name" "asc" ]
        ];
      };
      git = {
        add = lib.nixvim.mkRaw ''
          function(path)
          return true
          end
          '';
        mv = lib.nixvim.mkRaw ''
          function(src_path, dest_path)
          return true
          end
          '';
        rm = lib.nixvim.mkRaw ''
          function(path)
          return true 
          end
          '';
      };
      float = {
        padding = 2;
        max_width = 0;
        max_height = 0;
        win_options = {
          winblend = 0;
        };
        preview_split = "auto";
        override = lib.nixvim.mkRaw ''
          function(conf)
          return conf
          end
          '';
      };
      preview_win = {
        update_on_cursor_moved = true;
        preview_method = "fast_scratch";
        disable_preview = lib.nixvim.mkRaw ''
          function(filename)
          return false
          end
          '';
      };
      confirmation = {
        max_width = 0.9;
        min_width = [ 40 0.4 ];
        max_height = 0.9;
        min_height = [ 5 0.1 ];
        win_options = {
          winblend = 0;
        };
      };
      progress = {
        max_width = 0.9;
        min_width = [ 40 0.4 ];
        max_height = [ 10 0.9 ];
        min_height = [ 5 0.1 ];
        minimized_border = "none";
        win_options = {
          winblend = 0;
        };
      };
    };
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}
