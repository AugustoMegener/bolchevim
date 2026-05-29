{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    luasnip
    cmp_luasnip 
  ];

  plugins.nvim-autopairs.enable = true;

  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      snippet = {
        expand = lib.nixvim.mkRaw ''
          function(args)
            luasnip.lsp_expand(args.body)
          end
        '';
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
    };
  };
}
