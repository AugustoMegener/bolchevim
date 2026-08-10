{ lib, ... }:
{
  plugins.notify = {
    enable = true;
    settings = {
      background_colour = "#26211c";
      timeout = 3000;
      max_height = lib.nixvim.mkRaw ''
        function()
          return math.floor(vim.o.lines * 0.4)
        end
      '';
      max_width = lib.nixvim.mkRaw ''
        function()
          return math.floor(vim.o.columns * 0.4)
        end
      '';
    };
  };

  extraConfigLua = ''
    local orig_notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match("checkboxes") or msg:match("legacy_commands") then return end
      orig_notify(msg, ...)
    end
  '';
}
