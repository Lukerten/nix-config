{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.kotlin-language-server;
      config =
        # lua
        ''
          -- Kotlin Language Server
          lspconfig.kotlin_language_server.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.kotlin-language-server}/bin/kotlin-language-server'},
            filetypes = { 'kotlin' },
            root_dir = util.root_pattern('settings.gradle', 'build.gradle', '.git'),
          }
        '';
    }
  ];
  format = [
    {
      package = pkgs.ktlint;
      config =
        # lua
        ''
          -- Kotlin formatting: ktlint
          table.insert(ls_sources, none_ls.builtins.formatting.ktlint)
        '';
    }
  ];
  extraPackages = [];
  extraPlugins = [];
}
