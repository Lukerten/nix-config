{
  programs.nixvim.plugins = {
    nix.enable = true;
    conform-nvim.settings.formatters_by_ft.nix = ["alejandra"];

    lsp.servers.nil_ls.enable = true;
    lsp.servers.nixd.enable = true;

    none-ls.sources = {
      formatting.alejandra.enable = true;
      diagnostics.statix.enable = true;
      diagnostics.deadnix.enable = true;
      code_actions.statix.enable = true;
    };
  };
}
