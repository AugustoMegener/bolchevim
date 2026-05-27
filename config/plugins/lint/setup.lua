require("lint").linters_by_ft = {
    kotlin = { "ktlint" },
    typescript = { "eslint_d" },
    javascript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    nix = { "nix" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*" },
    callback = function()
        require("lint").try_lint()
    end,
})
