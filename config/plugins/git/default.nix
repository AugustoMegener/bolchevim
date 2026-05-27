{ pkgs, ... }:
{
    extraPlugins = with pkgs.vimPlugins; [
        (pkgs.vimUtils.buildVimPlugin {
            name = "vgit-nvim";
            doCheck = false;
            src = pkgs.fetchFromGitHub {
                owner = "tanvirtin";
                repo = "vgit.nvim";
                rev = "main";
                hash = "sha256-XDLylDFgWnZWt2W3yiH5a5LXxoTm5UanXMVeFqOa3Is=";
            };
        })
    ];
    extraConfigLua = builtins.readFile ./setup.lua;
}
