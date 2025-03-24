{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.bash-language-server;
      config =
        # lua
        ''
          -- Bash Language Server
          lspconfig.bashls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.bash-language-server}/bin/bash-language-server'};
          }
        '';
    }
  ];
  format = [];
  extraPackages = [];
  extraPlugins = [];
}
