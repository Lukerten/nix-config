{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            local lspconfig = require('lspconfig')
            function add_lsp(server, options)
              if not options["cmd"] then
                options["cmd"] = server["document_config"]["default_config"]["cmd"]
              end
              if not options["capabilities"] then
                options["capabilities"] = {}
              end
              options["capabilities"] = vim.tbl_extend("keep",
                options["capabilities"],
                require("cmp_nvim_lsp").default_capabilities()
              )

              if vim.fn.executable(options["cmd"][1]) == 1 then
                server.setup(options)
              end
            end

            -- Config: Nixd
            local nixd_config = {
              settings = {
                nixd = {
                  formatting = { command = { "alejandra" }}
                }
              }
            }

            -- Config: Pylsp
            local pylsp_config = {
              settings = {
                pylsp = {
                  plugins = {
                    ruff = {
                      severities = { ["F401"] = "W" }
                    }
                  }
                }
              },
              capabilities = {
                experimental = {
                  inlayHintProvider = true,
                }
              }
            }

            -- Config: Texlab
            local texlab_config = {
              chktex = {
                onEdit = true,
                onOpenAndSave = true
              }
            }

            add_lsp(lspconfig.bashls, {})
            add_lsp(lspconfig.biome, {})
            add_lsp(lspconfig.clangd, {})
            add_lsp(lspconfig.cssls, {})
            add_lsp(lspconfig.dartls, {})
            add_lsp(lspconfig.dockerls, {})
            add_lsp(lspconfig.docker_compose_language_service, {})
            add_lsp(lspconfig.golangci_lint_ls, {})
            add_lsp(lspconfig.gopls, {})
            add_lsp(lspconfig.html, {})
            add_lsp(lspconfig.jdtls, {})
            add_lsp(lspconfig.jsonls, {})
            add_lsp(lspconfig.marksman, {})
            add_lsp(lspconfig.kotlin_language_server, {})
            add_lsp(lspconfig.lua_ls, {})
            add_lsp(lspconfig.nixd, nixd_config)
            add_lsp(lspconfig.phpactor, {})
            add_lsp(lspconfig.pylsp, pylsp_config)
            add_lsp(lspconfig.ruff, {})
            add_lsp(lspconfig.rust_analyzer, {})
            add_lsp(lspconfig.sqls, {})
            add_lsp(lspconfig.taplo, {})
            add_lsp(lspconfig.terraformls, {})
            add_lsp(lspconfig.texlab, texlab_config)
            add_lsp(lspconfig.ts_ls, {})
          '';
      }
    ];
    extraPackages = with pkgs; [
      bash-language-server
      biome
      clang-tools
      dart
      docker-compose-language-service
      dockerfile-language-server-nodejs
      golangci-lint
      golangci-lint-langserver
      gopls
      marksman
      kotlin-language-server
      lua-language-server
      nixd
      phpactor
      nodePackages.typescript-language-server
      sql-formatter
      ruff
      (python3.withPackages (p: (with p; [
        python-lsp-ruff
        python-lsp-server
      ])))
      rust-analyzer
      sqls
      taplo
      taplo-lsp
      terraform-ls
      texlab
      typescript
      typescript-language-server
      yaml-language-server

      vscode-langservers-extracted
    ];
  };
}
