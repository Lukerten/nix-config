{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.nodePackages.vscode-json-languageserver;
      config = ''
        -- JSON Language Server
        lspconfig.jsonls.setup{
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = {'${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver', '--stdio'},
          filetypes = { 'json', 'jsonc' },
          root_dir = util.find_git_ancestor,
          single_file_support = true,
          init_options = {
            provideFormatter = true,
          },
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
