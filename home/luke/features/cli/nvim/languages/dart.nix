{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.dart;
      config = ''
        -- Dart Language Server
        lspconfig.dartls.setup{
          cmd = { '${pkgs.dart}/bin/dart', 'language-server', '--protocol=lsp' },
          filetypes = { 'dart' },
          on_attach = attach_keymaps,
          init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = true,
            closingLabels = true,
            outline = true,
            flutterOutline = true,
          },
          settings = {
            dart = {
              completeFunctionCalls = true,
              showTodos = true,
            },
          },
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
