{ ... }:
{
  extraConfigLua = builtins.readFile ./setup.lua;
}
