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
local function git_run(args, cwd)
  vim.fn.jobstart(vim.list_extend({ "git" }, args), {
    cwd = cwd,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("git " .. table.concat(args, " ") .. " failed", vim.log.levels.WARN)
      end
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = {
    "MiniFilesActionCreate",
    "MiniFilesActionCopy",
    "MiniFilesActionMove",
    "MiniFilesActionRename",
    "MiniFilesActionDelete",
  },
  callback = function(event)
    local entry = event.data
    local event_name = event.match

    if event_name == "MiniFilesActionDelete" then
      git_run({ "rm", "-f", entry.from }, vim.fn.fnamemodify(entry.from, ":h"))
      return
    end

    if entry.to then
      git_run({ "add", entry.to }, vim.fn.fnamemodify(entry.to, ":h"))
    end

    if (event_name == "MiniFilesActionMove" or event_name == "MiniFilesActionRename")
      and entry.from and entry.from ~= entry.to then
      git_run({ "add", "-A", entry.from }, vim.fn.fnamemodify(entry.from, ":h"))
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(event)
    local path = event.match
    if vim.fn.filereadable(path) == 0 then return end
    vim.fn.jobstart({ "git", "add", path }, {
      cwd = vim.fn.fnamemodify(path, ":h"),
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("git add failed for " .. path, vim.log.levels.WARN)
        end
      end,
    })
  end,
})
  '';
}
