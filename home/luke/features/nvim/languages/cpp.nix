{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.cpp = ["clang_format"];
    none-ls.sources.formatting.clang_format.enable = true;
    lsp.servers.clangd.enable = true;

    luasnip.fromSnipmate = [
      {
        paths = ../snippets/store/snippets/cpp.snippets;
        include = ["cpp"];
      }
      {
        paths = ../snippets/store/UltiSnips/cpp.snippets;
        include = ["cpp"];
      }
      {
        paths = ../snippets/store/snippets/c.snippets;
        include = ["c"];
      }
      {
        paths = ../snippets/store/UltiSnips/c.snippets;
        include = ["c"];
      }
    ];
  };
}
