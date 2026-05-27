local colors = {
  fg0 = "#ead9c5",
  bg1 = "#40392d",
  bg3 = "#312b24",
  blue = "#4eb0cf",
  aqua = "#689d6a",
  green = "#6bc99d",
  orange = "#f29554",
  purple = "#9595d9",
  red = "#f25146",
  yellow = "#e3a824",
}

local gruvbox = {
  normal = {
    a = { fg = colors.bg1, bg = colors.orange, gui = "bold" },
    b = { fg = colors.fg0, bg = colors.bg3 },
    c = { fg = colors.fg0, bg = colors.bg1 },
  },
insert = {
    a = { fg = colors.bg1, bg = colors.green, gui = "bold" },
  },
  visual = {
    a = { fg = colors.bg1, bg = colors.purple, gui = "bold" },
  },
  replace = {
    a = { fg = colors.bg1, bg = colors.red, gui = "bold" },
  },
  command = {
    a = { fg = colors.bg1, bg = colors.yellow, gui = "bold" },
  },
  inactive = {
    a = { fg = colors.fg0, bg = colors.bg3 },
    b = { fg = colors.fg0, bg = colors.bg3 },
    c = { fg = colors.fg0, bg = colors.bg1 },
  },
}

local mode_colors = {
  n = colors.orange,
  i = colors.green,
  v = colors.purple,
  V = colors.purple,
  ["\22"] = colors.purple,
  R = colors.red,
  c = colors.yellow,
}

local function mode_cap_color()
  return { fg = mode_colors[vim.fn.mode()] or colors.orange, bg = "NONE" }
end

require("lualine").setup({
  options = {
    theme = gruvbox,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    inactive_sections = {
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        function()
          return ""
        end,
        padding = 0,
        color = { fg = colors.bg1, bg = "NONE" },
      },
    },
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {
      {
        function()
          return ""
        end,
        padding = 0,
        color = { fg = "#c7b296", bg = "NONE" },
      },
    },
  },
  sections = {
    lualine_a = {
      {
        function()
          return ""
        end,
        padding = 0,
        color = mode_cap_color,
      },
      "mode",
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { 
      "filename",
      {
        function()
          return require("noice").api.status.command.get()
        end,
        cond = function()
          return require("noice").api.status.command.has()
        end,
      },
    }, 
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = {
      "location",
      {
        function()
          return ""
        end,
        padding = 0,
        color = mode_cap_color,
      },
    },
  },
})

local mode_cursor_colors = {
  n = "#f29554",
  i = "#6bc99d",
  v = "#9595d9",
  V = "#9595d9",
  ["\22"] = "#9595d9",
  R = "#f25146",
  c = "#e3a824",
}

vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local color = mode_cursor_colors[vim.fn.mode()] or "#f29554"
    vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = color })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
    vim.api.nvim_set_hl(0, "SmearCursorHideable", { fg = "none", bg = color, blend = 0 }) 
    require("smear_cursor.color").clear_cache()
  end,
})

local smear_color = require("smear_cursor.color") -- adiciona daqui pra baixo
local _unhide = smear_color.unhide_real_cursor
smear_color.unhide_real_cursor = function()
  _unhide()
  local color = mode_cursor_colors[vim.fn.mode()] or "#f29554"
  vim.api.nvim_set_hl(0, "SmearCursorHideable", { fg = "none", bg = color, blend = 0 })
end
