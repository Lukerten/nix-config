{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.haskell-language-server;
      config = ''
        -- Haskell Language Server
        lspconfig.hls.setup{
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = {'${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper'},
          filetypes = { 'haskell', 'lhaskell' },
          root_dir = util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'),
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
