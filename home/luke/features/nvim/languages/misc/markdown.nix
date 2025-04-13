{
  programs.nixvim.plugins = {
    lsp.servers.marksman.enable = true;
    none-ls.sources.formatting.prettier.enable = true;
    conform-nvim.settings.formatters_by_ft.markdown = {
      __unkeyed-1 = "prettierd";
      __unkeyed-2 = "prettier";
      stop_after_first = true;
    };

    # Snippet Support
    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/markdown.snippets;
        include = ["markdown"];
      }
    ];

    # Extra Plug: render Markdown
    render-markdown = {
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
  };
}
