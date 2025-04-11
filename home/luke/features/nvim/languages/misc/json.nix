{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.json = {
      __unkeyed-1 = "prettierd";
      __unkeyed-2 = "prettier";
      stop_after_first = true;
    };
    lsp.servers.jsonls.enable = true;
    none-ls.sources.formatting.prettier.enable = true;
  };
}
