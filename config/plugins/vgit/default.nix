{ pkgs, ... }:
let
  vgit = pkgs.vimUtils.buildVimPlugin {
    name = "vgit";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "tanvirtin";
      repo = "vgit.nvim";
      rev = "v1.0.6";
      hash = "sha256-2GkAs8f/jwKGsabhr1Ik90wh19QRBEwvsn5fVGTmBaQ=";
    };
  };
in
{
  extraPlugins = [

    vgit
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}
