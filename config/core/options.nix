{ ... }:
{
  globals = {
    mapleader = "ç";
    maplocalleader = "ç";
  };

  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
    signcolumn = "yes";
    scrolloff = 8;
    sidescrolloff = 8;
    wrap = false;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;
    splitbelow = true;
    splitright = true;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    updatetime = 50;
    timeoutlen = 300;
    completeopt = "menu,menuone,noselect";
    pumheight = 10;
    showmode = false;
    winborder = "rounded";
    clipboard = "unnamedplus";
    undofile = true;
    spell = false;
    guicursor = "n-v-c:block-Cursor,i:ver25-Cursor,r:hor20-Cursor";
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
    conceallevel = 2;
  };

  extraConfigLua = ''

    vim.cmd([[
      syntax match EscapeSeq /\\n/ conceal cchar=  
      syntax match EscapeSeqOther /\\./ conceal 
    ]])

    vim.diagnostic.config({
      signs = true,
      underline = true,
      update_in_insert = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text", "gitcommit" },
      callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "pt,en"
      end,
    })

    local orig_virtual_text = vim.diagnostic.handlers.virtual_text

    vim.diagnostic.handlers.virtual_text = {
      show = function(ns, bufnr, diagnostics, opts)
        diagnostics = vim.tbl_filter(function(diagnostic)
          return diagnostic.source ~= "spell"
        end, diagnostics)

        orig_virtual_text.show(ns, bufnr, diagnostics, opts)
      end,
      hide = orig_virtual_text.hide,
    }

if vim.g.started_by_firenvim then
  vim.opt.guifont = "Go Mono Nerd Font:h14"
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0

  require("noice").setup({ enabled = false })

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    callback = function()
      firenvim.resizeEditor()
    end,
  })

  vim.keymap.set({ "n", "i" }, "<C-CR>", function()
    vim.fn["firenvim#press_keys"]("<CR>")
    vim.cmd("stopinsert")
  end)
end





if vim.g.started_by_firenvim then
  vim.opt.guifont = "Go Mono Nerd Font:h9"
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0

  require("barbecue").setup({ enabled = false })

  --[[vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    callback = function()
      firenvim.resizeEditor()
    end,
  })]]

if vim.g.started_by_firenvim then
  vim.opt.guifont = "Go Mono Nerd Font:h9"
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0

  require("barbecue").setup({ enabled = false })
  require("noice").setup({
    routes = {
      {
        filter = { event = "msg_show", find = "E36" },
        opts = { skip = true },
      },
    },
  })
end

local ns = vim.api.nvim_create_namespace("escape_conceals")

local patterns = {
  { pat = "\\n", icon = "↵" },
  { pat = "\\0", icon = "󰨿" },
  { pat = "->", icon = " " },
  { pat = "=>", icon = " " },
  { pat = "()", icon = " " },
  { pat = "==", icon = " " },
  { pat = "=<", icon = " " },
  { pat = "!=", icon = " " },
}


local defined = table.concat(vim.tbl_map(function(e) return e.pat:sub(2) end, patterns))

vim.cmd(string.format([[
  syntax match myEscapeSlash /\\\ze[^%s]/ conceal
  syntax match myEscapeChar /\\\zs[^%s]/
]], defined, defined))


local function apply(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    for _, entry in ipairs(patterns) do
      local s = 1
      while true do
        local start, finish = line:find(entry.pat, s, true)
        if not start then break end
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, start - 1, {
          end_col = finish,
          conceal = "",
          virt_text = {{ entry.icon, "Special" }},
          virt_text_pos = "inline",
        })
        s = finish + 1
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  callback = function(ev)
    apply(ev.buf)
  end,
})

end
  '';
}
