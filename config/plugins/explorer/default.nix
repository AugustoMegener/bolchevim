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
        mappings = {
          toggle = "gS";
          split = "";
          join = "";
        };
      };
    };
  };
  
  extraConfigLua = ''
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionCreate",
  callback = function(event)
    local entry = event.data
    if entry.to then
      vim.fn.jobstart({ "git", "add", entry.to }, {
        cwd = vim.fn.fnamemodify(entry.to, ":h"),
        on_exit = function(_, code)
          if code ~= 0 then
            vim.notify("failed git add attempt for " .. entry.to, vim.log.levels.WARN)
          end
        end,
      })
    end
  end,
})
  '';
}
