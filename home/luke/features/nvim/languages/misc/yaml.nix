{
  programs.nixvim.plugins = {
    conform-nvim.settings.formatters_by_ft.yaml = ["yamlfmt"];
    lsp.servers.yamlls.enable = true;
    none-ls.sources.formatting.yamlfmt.enable = true;
    none-ls.sources.diagnostics.yamllint.enable = true;
  };
}
