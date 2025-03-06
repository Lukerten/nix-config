{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.vscode-langservers-extracted;
      config = ''
        -- CSS Language Server
        lspconfig.cssls.setup{
          on_attach = attach_keymaps,
          cmd = {'${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server'};
          filetypes = {'css', 'scss', 'less'};
          settings = {
            css = {
              validate = true;
            };
            less = {
              validate = true;
            };
            scss = {
              validate = true;
            };
          };
        }
      '';
    }
    {
      package = pkgs.tailwindcss-language-server;
      config = ''
        -- TailwindCSS Language Server
        lspconfig.tailwindcss.setup{
          cmd = {'${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server'},
          filetypes = {'css', 'scss', 'less', 'html', 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
          root_dir = require('lspconfig/util').root_pattern('tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.lua', 'package.json'),
          on_attach = attach_keymaps;
          capabilities = capabilities;
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
