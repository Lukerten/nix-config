{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        background = {
          light = "latte";
          dark = "mocha";
        };

        show_end_of_buffer = true;
        disable_underline = true;
        term_colors = true;
        integrations = {
          aerial = true;
          blink_cmp = true;
          dap = {
            enabled = true;
            enable_ui = true;
          };
          indent_blankline = {
            enabled = true;
            colored_indent_levels = true;
          };
          lsp_trouble = true;
          markdown = true;
          mason = true;
          mini.enabled = true;

          native_lsp = {
            enabled = true;
            virtual_text = {
              errors = ["italic"];
              hints = ["italic"];
              warnings = ["italic"];
              information = ["italic"];
            };
            underlines = {
              errors = ["underline"];
              hints = ["underline"];
              warnings = ["underline"];
              information = ["underline"];
            };
            inlay_hints = {
              background = true;
            };
          };
          noice = true;
          notify = true;
          symbols_outline = true;
          snacks = true;
          treesitter = true;
        };
      };
    };
  };
}
