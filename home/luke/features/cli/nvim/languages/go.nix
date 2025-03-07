{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.gopls;
      config =
        # lua
        ''
          lspconfig.gopls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.gopls}/bin/gopls'};
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
              },
            },
          }
        '';
    }
    {
      package = pkgs.golangci-lint-langserver;
      config =
        # lua
        ''
          lspconfig.golangci_lint_ls.setup{
            cmd = {'${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver'};
            capabilities = capabilities;
            on_attach = attach_keymaps,
            init_options = {
              command = { '${pkgs.golangci-lint}/bin/golangci-lint', 'run', '--out-format', 'json' },
            },
            root_dir = function(fname)
              return util.root_pattern(
                '.golangci.yml',
                '.golangci.yaml',
                '.golangci.toml',
                '.golangci.json',
                'go.work',
                'go.mod',
                '.git'
              )(fname)
            end,
          }
        '';
    }
  ];
  formatter = null;
  extraPackages = with pkgs; [
    go
    golangci-lint
    gotools
  ];
  extraPlugins = [];
}
