local ws_colors = { "#da9a22", "#f25146", "#4396b7" }

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
