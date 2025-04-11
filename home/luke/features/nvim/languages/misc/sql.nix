{
  programs.nixvim.plugins = {
    none-ls.sources.formatting.sqlformat.enable = true;
    conform-nvim.settings.formatters_by_ft.sql = ["sqlformat"];
  };
}
