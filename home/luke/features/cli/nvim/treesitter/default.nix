{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      rust-vim
      dart-vim-plugin
      plantuml-syntax
      vim-markdown
      vim-nix
      vim-toml
      vim-syntax-shakespeare
      gemini-vim-syntax
      mermaid-vim
      kotlin-vim
      haskell-vim
      pgsql-vim
      vim-terraform
      vim-jsx-typescript
      vim-caddyfile
      {
        plugin = vimtex;
        config =
          # vim
          ''
            let g:vimtex_view_method = '${
              if config.programs.zathura.enable
              then "zathura"
              else "general"
            }'
          '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config =
          # lua
          ''
            vim.opt.conceallevel = 2

            require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,
                disable = {},
              },

              auto_install = false,
              ensure_installed = {},

              incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "gnn",
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
                },
              }
            }
          '';
      }
    ];
  };
}
