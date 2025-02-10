# | Language                  | LSP                        | Formatter        |
# |---------------------------|----------------------------|------------------|
# | Bash                      | bash-language-server       |                  |
# | C/C++                     | clangd                     | clang-format     |
# | CSS                       | vscode-css-language-server |                  |
# | Docker Compose            | docker-compose-langs       |                  |
# | Docker                    | docker-langserver          |                  |
# | Erlang                    | erlang                     |                  |
# | Go                        | gopls                      | dlv              |
# | HTML                      | vscode-html-language-server|                  |
# | HYPR                      | hyprls                     |                  |
# | Java                      | jdtls                      |                  |
# | JavaScript                | typescript-language-server | prettier         |
# | JSON                      | vscode-json-language-server|                  |
# | Lean                      | lean                       |                  |
# | Lua                       | lua-language-server        |                  |
# | Markdown                  | marksman                   |                  |
# | Meson                     | mesonlsp                   |                  |
# | Nix                       | nix-language-server        | alejandra        |
# | PHP                       | intelephense               |                  |
# | Prolog                    | swipl                      |                  |
# | Python                    | ruff                       |                  |
# | Rust                      | rust-analyzer              |                  |
# | Svelte                    | svelteserver               |                  |
# | Terraform                 | terraform-ls               |                  |
# | Vue                       | vue-language-server        |                  |
# | YAML                      | yaml-language-server       |                  |
# | Zig                       | zig-language-server        |                  |
{pkgs, ...}: {
  programs.helix = {
    extraPackages = with pkgs; [
      bash-language-server
      biome
      clang-tools
      docker-compose-language-service
      dockerfile-language-server-nodejs
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
      marksman
      nil
      nixd
      nixpkgs-fmt
      nodePackages.prettier
      nodePackages.typescript-language-server
      sql-formatter
      ruff
      (python3.withPackages (p: (with p; [
        python-lsp-ruff
        python-lsp-server
      ])))
      rust-analyzer
      taplo
      taplo-lsp
      terraform-ls
      typescript
      vscode-langservers-extracted
      yaml-language-server
    ];
    languages = {
      language-server.biome = {
        command = "biome";
        args = ["lsp-proxy"];
      };

      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language-server.typescript-language-server.config.tsserver = {
        path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
      };

      language = [
        {
          name = "css";
          language-servers = ["vscode-css-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.css"];
          };
          auto-format = true;
        }
        {
          name = "go";
          language-servers = ["gopls" "golangci-lint-lsp"];
          formatter = {
            command = "goimports";
          };
          auto-format = true;
        }
        {
          name = "html";
          language-servers = ["vscode-html-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.html"];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.json"];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.jsonc"];
          };
          file-types = ["jsonc" "hujson"];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.jsx"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.md"];
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = ["pylsp"];
          formatter = {
            command = "sh";
            args = ["-c" "ruff check --select I --fix - | ruff format --line-length 88 -"];
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = ["vscode-css-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.scss"];
          };
          auto-format = true;
        }
        {
          name = "sql";
          formatter = {
            command = "sql-formatter";
            args = ["-l" "postgresql" "-c" "{\"keywordCase\": \"lower\", \"dataTypeCase\": \"lower\", \"functionCase\": \"lower\", \"expressionWidth\": 120, \"tabWidth\": 4}"];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {
            command = "taplo";
            args = ["fmt" "-o" "column_width=120" "-"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.tsx"];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.ts"];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.yaml"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
