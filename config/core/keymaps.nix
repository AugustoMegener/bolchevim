{ lib, ... }:
{
  keymaps = [
{
  mode = "n";
  key = "<Esc>";
  action = lib.nixvim.mkRaw "function() vim.fn.setreg('/', '') vim.cmd('noh') end";
}
    {
      mode = "n";
      key = "<Space>";
      action = "<Nop>";
    }
    {
      mode = "n";
      key = "<leader>e";
      #action = "<cmd>Oil<cr>";
      #action = "<cmd>lua MiniFiles.open()<CR>";
      action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>"; 
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<cr>";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Telescope git_status<cr>";
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>Telescope git_commits<cr>";
    }
    {
      mode = "n";
      key = "K";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.hover() end";
    }
    {
      mode = "n";
      key = "gd";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.definition() end";
    }
    {
      mode = "n";
      key = "gr";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.references() end";
    }
    {
      mode = "n";
      key = "gi";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.implementation() end";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.rename() end";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.code_action() end";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw "function() vim.lsp.buf.format() end";
    }
    {
      mode = "n";
      key = "<leader>d";
      action = lib.nixvim.mkRaw "function() vim.diagnostic.open_float() end";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<cmd>split<cr>";
    }
    {
      mode = "n";
      key = "<leader>v";
      action = "<cmd>vsplit<cr>";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<cr>";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprev<cr>";
    }
    
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>DapToggleBreakpoint<cr>";
    }


    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
    }
    {
      mode = "n";
      key = "<leader>cb";
      action = "<cmd>BufferLinePickClose<cr>";
    }
    {
      mode = "n";
      key = "<leader>cob";
      action = "<cmd>BufferLineCloseOthers<cr>";
    }
  ];
}
