{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.vscode-langservers-extracted;
      config =
        # lua
        ''
          -- HTML Language Server
          lspconfig.html.setup{
            cmd = { '${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server', '--stdio' },
            filetypes = { 'html', 'templ' },
            on_attach = attach_keymaps,
            root_dir = util.root_pattern('package.json', '.git'),
            single_file_support = true,
            settings = {},
            init_options = {
              provideFormatter = true,
              embeddedLanguages = { css = true, javascript = true },
              configurationSection = { 'html', 'css', 'javascript' },
            },
          }
        '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
