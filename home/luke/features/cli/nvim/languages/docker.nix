{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.dockerfile-language-server-nodejs;
      config =
        # lua
        ''
          -- Dockerfile Language Server
          lspconfig.dockerls.setup{
            cmd = { '${pkgs.dockerfile-language-server-nodejs}/bin/docker-langserver', '--stdio' },
            filetypes = { 'dockerfile' },
            root_dir = util.root_pattern 'Dockerfile',
            single_file_support = true,
            on_attach = attach_keymaps,
          }
        '';
    }
    {
      package = pkgs.docker-compose-language-service;
      config =
        # lua
        ''
          -- Docker Compose Language Server
          lspconfig.docker_compose_language_service.setup{
            cmd = { '${pkgs.docker-compose-language-service}/bin/docker-compose-langserver', '--stdio' },
            filetypes = { 'yaml.docker-compose' },
            root_dir = util.root_pattern 'docker-compose.yml',
            single_file_support = true,
            on_attach = attach_keymaps,
          }
        '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
