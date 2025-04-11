{
  # TODO: Factor this into a Highlight - then use matugen for better style
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        background = {
          light = "latte";
          dark = "mocha";
        };
        disable_underline = true;
        term_colors = true;
        integrations = {
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          notify = false;
          mini = {
            enabled = true;
            indentscope_color = "";
          };
        };
      };
    };
  };
}
