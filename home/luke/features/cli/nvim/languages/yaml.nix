{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.yaml-language-server;
      config =
        # lua
        ''
          -- YAML Language Server
          lspconfig.yamlls.setup{
            capabilities = capabilities,
            on_attach = attach_keymaps,
            filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
            root_dir = util.find_git_ancestor,
            cmd = {'${pkgs.yaml-language-server}/bin/yaml-language-server','--stdio'},
            settings = {
              -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
              redhat = { telemetry = { enabled = false } },
            },
          }
        '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
