{
  programs.nixvim.plugins = {
    none-ls.sources.formatting.opentofu_fmt.enable = true;
    none-ls.sources.diagnostics.trivy.enable = true;
    conform-nvim.settings.formatters_by_ft.terraform = ["tofu_fmt"];
    conform-nvim.settings.formatters_by_ft.tf = ["tofu_fmt"];
  };
}
