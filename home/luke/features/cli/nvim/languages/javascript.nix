{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.nodePackages.typescript-language-server;
      config =
        # lua
        ''
          -- TypeScript/JavaScript Language Server
          lspconfig.ts_ls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
          }
        '';
    }
    {
      package = pkgs.eslint_d;
      config =
        # lua
        ''
          -- ESLint Language Server
          lspconfig.eslint.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = { "${pkgs.eslint_d}/bin/eslint_d" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
          }
        '';
    }
    {
      package = pkgs.biome;
      config =
        # lua
        ''
          -- Biome Language Server
          lspconfig.biome.setup{
            cmd = { '${pkgs.biome}/bin/biome', 'lsp-proxy' },
            filetypes = {
              'astro',
              'css',
              'graphql',
              'javascript',
              'javascriptreact',
              'json',
              'jsonc',
              'svelte',
              'typescript',
              'typescript.tsx',
              'typescriptreact',
              'vue',
            },
            on_attach = attach_keymaps,
            root_dir = util.root_pattern('biome.json', 'biome.jsonc'),
            single_file_support = false,
          }
        '';
    }
  ];
  format = [
    {
      package = pkgs.nodePackages.prettier;
      config = ''
        -- JavaScript/TypeScript formatting: prettier
        table.insert(ls_sources, none_ls.builtins.formatting.prettier.with({
          command = "${pkgs.nodePackages.prettier}/bin/prettier",
        }))
      '';
    }
  ];
  extraPackages = with pkgs; [nodejs];
  extraPlugins = [];
}
