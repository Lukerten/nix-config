{
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    settings = {
      render_modes = true;
      signs.enabled = false;
      bullet = {
        icons = [
          "◆ "
          "• "
          "• "
        ];
        right_pad = 1;
      };
      heading = {
        sign = false;
        width = "full";
        position = "inline";
        border = true;
        icons = [
          "1 "
          "2 "
          "3 "
          "4 "
          "5 "
          "6 "
        ];
      };
      code = {
        sign = false;
        width = "block";
        position = "right";
        language_pad = 2;
        left_pad = 2;
        right_pad = 2;
        border = "thick";
        above = " ";
        below = " ";
      };
    };
  };
}
