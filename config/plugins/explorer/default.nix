{ pkgs, lib, ... }:
{
  extraPackages = with pkgs; [ fd ripgrep ];

  plugins.telescope = {
    enable = true;

    settings = {
      defaults = {
        border = true;
      };
      commands = {
        image_wezterm = lib.nixvim.mkRaw ''
          function(state)
            local node = state.tree:get_node()
            if node.type == "file" then
              require("image_preview").PreviewImage(node.path)
            end
          end
        '';
      };
    }; 
  };

  plugins.mini = {
    enable = true;
    modules = {
      files = {
        options = {
          permanent_delete = true;
          use_as_default_explorer = true;
        };
      };
      splitjoin = {

      };
    };
  };
}
