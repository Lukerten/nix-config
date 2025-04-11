{
  programs.nixvim.plugins = {
    none-ls.sources.formatting.just.enable = true;
    conform-nvim.settings.formatters_by_ft.just = ["just"];
  };
}
