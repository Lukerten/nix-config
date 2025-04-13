{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.cpp = ["clang_format"];
    none-ls.sources.formatting.clang_format.enable = true;
    lsp.servers.clangd.enable = true;
    luasnip.fromSnipmate = [
      {
        paths = ./vim-snippets/snippets/html.snippets;
        include = ["html"];
      }
    ];
  };
}
