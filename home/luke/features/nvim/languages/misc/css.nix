{
  programs.nixvim.plugins = {
    none-ls.sources.formatting.prettier.enable = true;
    conform-nvim.settings.formatters_by_ft.css = {
      __unkeyed-1 = "prettierd";
      __unkeyed-2 = "prettier";
      stop_after_first = true;
    };
    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/css.snippets;
        include = ["css"];
      }
    ];
  };
}
