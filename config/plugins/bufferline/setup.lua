local ws_colors = { "#da9a22", "#f25146", "#4396b7" }

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = { "|", "|" },
    indicator = { style = "underline" },
    show_buffer_close_icons = false,
    show_close_icon = false,
    left_trunc_marker = "󰇘",
    right_trunc_marker = "󰇘",
    modified_icon = "",
    offsets = {},
    color_icons = true,
    get_element_icon = function(element)
      local icon = require("nvim-web-devicons").get_icon(
        element.path,
        element.extension,
        { default = true }
      )
      return icon, nil
    end,
    custom_areas = {
      left = function()
        return { { text = "", fg = "#2b2622", bg = "#302b24" } }
      end,
      right = function()
        return { { text = "", fg = "#2b2622", bg = "#302b24" } }
      end,
    },
  },
  highlights = {
    fill = { bg = "#2b2622" },
    background = { fg = "#866f51", bg = "#2b2622" },
    buffer_visible = { fg = "#866f51", bg = "#2b2622" },
    buffer_selected = { fg = "#da9a22", bg = "#302b24", bold = true, italic = false },
    separator = { fg = "#383028", bg = "#2b2622" },
    separator_selected = { fg = "#383028", bg = "#302b24" },
    separator_visible = { fg = "#383028", bg = "#2b2622" },
    indicator_selected = { fg = "#da9a22", bg = "#302b24", underline = true, sp = "#da9a22" },
    modified = { fg = "#da9a22", bg = "#2b2622" },
    modified_selected = { fg = "#da9a22", bg = "#302b24" },
    tab = { fg = "#866f51", bg = "#2b2622" },
    tab_selected = { fg = "#da9a22", bg = "#302b24" },
    tab_separator = { fg = "#383028", bg = "#2b2622" },
    tab_separator_selected = { fg = "#383028", bg = "#302b24" },
  },
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buflisted = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.fn.buflisted(buf) == 1 then
        table.insert(buflisted, buf)
      end
    end

    table.sort(buflisted, function(a, b)
      return a < b
    end)

    local current_buf = vim.api.nvim_get_current_buf()
    local position = nil

    for i, buf in ipairs(buflisted) do
      if buf == current_buf then
        position = i
        break
      end
    end

    if position then
      local idx = ((position - 1) % 3) + 1
      local color = ws_colors[idx]

      vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", {
        fg = color,
        bg = "#302b24",
        underline = true,
        sp = color,
      })

      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", {
        fg = color,
        bg = "#302b24",
        bold = true,
        italic = false,
        underline = true,
      })
    end
  end,
})
