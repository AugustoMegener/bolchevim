local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    border = true,
  },
  commands = {
      image_wezterm = function(state)
        local node = state.tree:get_node()
        if node.type == "file" then
          require("image_preview").PreviewImage(node.path)
        end
      end,
  }
})


--[[
require("neo-tree").setup({
    window = {
        width = 30,
    },
    filesystem = {
        group_empty_dirs = true,
        scan_mode = "deep",
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        window = {
            width = 30,
            mappings = {
                ["<leader>p"] = "image_wezterm", -- " or another map
            },
        },
        commands = {
            image_wezterm = function(state)
                local node = state.tree:get_node()
                if node.type == "file" then
                    require("image_preview").PreviewImage(node.path)
                end
            end,
        },
    },
})]]

--[[vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      if vim.fn.isdirectory(arg) == 1 then
        require("neo-tree.command").execute({ action = "show", dir = arg })
      end
    end
  end,
})]]
