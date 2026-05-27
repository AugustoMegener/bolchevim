require("notify").setup({
    background_colour = "#2b2622",
    timeout = 3000,
    max_height = function()
        return math.floor(vim.o.lines * 0.4)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.4)
    end,
})
local orig_notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("checkboxes") or msg:match("legacy_commands") then return end
    orig_notify(msg, ...)
end
vim.notify = require("notify")
