require("nvim-surround").setup()

require("ibl").setup({
  indent = { 
      char = "│",
  },
  scope = { enabled = true },
})

require("colorizer").setup({
  user_default_options = {
    names = false,
  },
})

require("auto-save").setup()
