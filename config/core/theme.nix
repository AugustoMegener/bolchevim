{ ... }:
{
  extraFiles."lua/primary.lua".source = ./primary.lua;
  extraConfigLuaPost = ''
    require("primary").setup()
  '';
}
