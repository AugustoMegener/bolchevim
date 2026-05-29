
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*" },
    callback = function()
        require("lint").try_lint()
    end,
})
