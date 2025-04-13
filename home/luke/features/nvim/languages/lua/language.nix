{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.lua = ["stylua"];
    none-ls.sources.formatting.stylua.enable = true;
    lsp.servers.lua_ls = {
      enable = true;
      extraOptions.settings.Lua = {
        completion.callSnippet = "Replace";
        diagnostics.globals = ["vim"];
        telemetry.enabled = false;
        hint.enable = true;
      };
    };

    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/html.snippets;
        include = ["html"];
      }
    ];
  };
}
