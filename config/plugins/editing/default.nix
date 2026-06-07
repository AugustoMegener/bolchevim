	    settings = {
{
  plugins.vim-surround.enable = true;

  plugins.auto-save.enable = true;

  plugins.indent-blankline = {
    enable = true;  
    settings = {
      indent = { 
        char = "│";
      };
      scope = { enabled = true; };
    };
  };

  plugins.colorizer = {
    enable = true;

    settings = {
      user_default_options = {
        names = false;
      };
    };
  };

  plugins.auto-session = {
    enable = true;
    settings.pre_save_cmds = [ "lua pcall(MiniFiles.close)" ];
  };
}
