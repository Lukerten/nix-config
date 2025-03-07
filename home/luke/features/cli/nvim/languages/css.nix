{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.vscode-langservers-extracted;
      config =
        # lua
        ''
          -- CSS Language Server
          lspconfig.cssls.setup{
            cmd = {'${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server', "--stdio" };
            capabilities = default_capabilities,
            on_attach = attach_keymaps,
          }
        '';
    }
    {
      package = pkgs.tailwindcss-language-server;
      config =
        # lua
        ''
          -- TailwindCSS Language Server
          lspconfig.tailwindcss.setup{
            cmd = {'${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server'},
            root_dir = require('lspconfig/util').root_pattern('tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.lua', 'package.json'),
            capabilities = capabilities;
            on_attach = attach_keymaps;
          }
        '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
