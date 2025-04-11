{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.kotlin = ["ktfmt"];

    lsp.servers.kotlin-language-server.enable = true;

    none-ls.sources.formatting.ktfmt.enable = true;
  };
}
