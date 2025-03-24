{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.nil;
      config =
        # lua
        ''
          -- Nix Language Server
          lspconfig.nil_ls.setup{
            capabilities = capabilities,
            on_attach = attach_keymaps,
            cmd = {"${pkgs.nil}/bin/nil"},
            filetypes = { 'nix' },
            root_dir = util.root_pattern('flake.nix', 'default.nix', '.git'),
          }
        '';
    }
    {
      package = pkgs.nixd;
      config =
        # lua
        ''
          -- Nix Language Server
          lspconfig.nixd.setup{
            capabilities = capabilities,
            on_attach = attach_keymaps,
            cmd = {"${pkgs.nixd}/bin/nixd"},
            filetypes = { 'nix' },
            root_dir = util.root_pattern('flake.nix', 'default.nix', '.git'),
          }
        '';
    }
  ];
  formatter = {
    package = pkgs.alejandra;
    config =
      # lua
      ''
        -- Nix formatting: alejandra
        table.insert(ls_sources, none_ls.builtins.formatting.alejandra.with({
          command = "${pkgs.alejandra}/bin/alejandra",
        }))
      '';
  };
  extraPackages = [];
  extraPlugins = [];
}
