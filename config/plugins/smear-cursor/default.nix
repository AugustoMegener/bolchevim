{ lib, ... }:
{

  plugins.smear-cursor = {
    enable = true;
    settings = {
      opts = {
        cursor_color = "Cursor";        smear_between_buffers = true;
        smear_between_neighbor_lines = true;
        scroll_buffer_space = true;
        legacy_computing_symbols_support = false;
        smear_insert_mode = true;
      };
    };
  };

}
