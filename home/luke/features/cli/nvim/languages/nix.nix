{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.nil;
      config = ''
        -- Nix Language Server
        lspconfig.nil_ls.setup{
          capabilities = capabilities,
          on_attach = attach_keymaps,
          cmd = {"${pkgs.nil}/bin/nil"},
          filetypes = { 'nix' },
          root_dir = util.root_pattern('flake.nix', 'default.nix', '.git'),
          settings = {
            formatting = {
              command = {"${pkgs.alejandra}/bin/alejandra", "--quiet"},
            },
          },
        }
      '';
    }
    {
      package = pkgs.nixd;
      config = ''
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
    config = ''
      -- Nix formatting: alejandra
      table.insert(ls_sources, null_ls.builtins.formatting.alejandra.with({
        command = "${pkgs.alejandra}/bin/alejandra",
      }))
    '';
  };
  extraPackages = [];
  extraPlugins = [];
}
