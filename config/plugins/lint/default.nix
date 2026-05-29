{ pkgs, ... }:
{ 
  extraPackages = with pkgs; [
    ktlint
    eslint_d
  ];

  plugins.lint = {
    enable = true;
    lintersByFt = {
      kotlin = [ "ktlint" ];
      typescript = [ "eslint_d" ];
      javascript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      nix = [ "nix" ];
    };
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}
