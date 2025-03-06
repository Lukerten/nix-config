{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.kotlin-language-server;
      config = ''
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
  formatter = {
    package = pkgs.ktlint;
    config = ''
      -- Kotlin formatting: ktlint
      table.insert(ls_sources, null_ls.builtins.formatting.ktlint.with({
        command = "${pkgs.ktlint}/bin/ktlint",
      }))
    '';
  };
  extraPackages = [];
  extraPlugins = [];
}
