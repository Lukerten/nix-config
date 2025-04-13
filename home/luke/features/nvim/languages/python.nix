{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.python = ["black"];
    lsp.servers = {
      pylsp.enable = true;
      pyright.enable = true;
      ruff.enable = true;
    };
    none-ls.sources.formatting.black.enable = true;
    luasnip.fromSnipmate = [
      {
        paths = ../snippets/store/snippets/python.snippets;
        include = ["python"];
      }
    ];
  };
}
