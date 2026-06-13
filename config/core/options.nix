{ ... }:
{
  globals = {
    mapleader = "ç";
    maplocalleader = "ç";
  };

  opts = {
    concealcursor = "nvic";
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

  { pat = "->", icon = " " },

  { pat = "=>", icon = " " },

  { pat = "()", icon = " " },

  { pat = "==", icon = " "},

  { pat = ">=", icon = " "},

  { pat = "<=", icon = " " },

  { pat = "!=", icon = " "},

}

local function apply(bufnr, top, bot)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, top, bot)
  local lines = vim.api.nvim_buf_get_lines(bufnr, top, bot, false)
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1

  for i, line in ipairs(lines) do
    local lnum = top + i - 1
    if lnum ~= cursor_row then
      for _, entry in ipairs(patterns) do
        local s = 1
        while true do
          local start, finish = line:find(entry.pat, s, true)
          if not start then break end
          vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, start - 1, {
            end_col = finish,
            conceal = "",
            virt_text = {{ entry.icon, "" }},
            virt_text_pos = "inline",
          })
          s = finish + 1
        end
      end
    end
  end
end

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, _, bufnr, topline, botline)
    apply(bufnr, topline, botline)
  end,
})
'';
}
