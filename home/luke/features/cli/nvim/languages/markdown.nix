{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.marksman;
      config = ''
        -- Markdown Language Server
        lspconfig.marksman.setup{
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = {'${pkgs.marksman}/bin/marksman', 'server'},
          filetypes = { 'markdown' },
          root_dir = util.root_pattern('.git', 'markdown.config.json'),
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
