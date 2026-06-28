{ pkgs, ... }:
let
  compile-mode-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "compile-mode-nvim";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "ej-shafran";
      repo = "compile-mode.nvim";
      rev = "v5.14.0";
      hash = "sha256-cUh3ekDENsVH/XVEHeV7KVKTIlkoht+rHtXnR3C+lGY=";
    };
  };
in
{
  extraPlugins = [
    pkgs.vimPlugins.plenary-nvim
    compile-mode-nvim
  ];

  extraConfigLua = ''
    vim.g.compile_mode = {
      default_command = "nix run ",
    }
  '';
}
