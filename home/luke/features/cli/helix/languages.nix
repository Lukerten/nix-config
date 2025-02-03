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
{
  config,
  pkgs,
  ...
}: {
  programs.helix = {
    languages = {
      language = [
        {
          name = "bash";
          language-servers = ["bash-ls"];
        }
        {
          name = "c";
          formatter.command = "clang-format";
          language-servers = ["clangd"];
        }
        {
          name = "cpp";
          language-servers = ["clangd"];
          formatter.command = "clang-format";
        }
        {
          name = "css";
          language-servers = ["css-ls"];
        }
        {
          name = "docker-compose";
          language-servers = ["docker-compose-ls"];
        }
        {
          name = "dockerfile";
          language-servers = ["docker-ls"];
        }
        {
          name = "erlang";
          language-servers = ["erlang-ls"];
        }
        {
          name = "go";
          language-servers = ["gopls"];
          formatter.command = "dlv";
        }
        {
          name = "html";
          language-servers = ["html-ls"];
        }
        {
          name = "hyprlang";
          language-servers = ["hypr-ls"];
        }
        {
          name = "java";
          language-servers = ["jdtls"];
        }
        {
          name = "javascript";
          language-servers = ["ts-ls"];
          formatter.command = "prettier";
        }
        {
          name = "json";
          language-servers = ["json-ls"];
        }
        {
          name = "lua";
          language-servers = ["lua-lsp"];
        }
        {
          name = "markdown";
          language-servers = ["marksman"];
        }
        {
          name = "meson";
          language-servers = ["mesonlsp"];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "alejandra";
          language-servers = ["nixd" "nil"];
        }
        {
          name = "php";
          language-servers = ["intelephense"];
        }
        {
          name = "python";
          language-servers = ["ruff"];
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
        }
        {
          name = "svelte";
          language-servers = ["svelte-ls"];
        }
        {
          name = "tfvars";
          language-servers = ["terraform-ls"];
        }
        {
          name = "vue";
          language-servers = ["vue-ls"];
        }
        {
          name = "yaml";
          language-servers = ["yaml-ls"];
        }
        {
          name = "zig";
          language-servers = ["zig-ls"];
        }
      ];
      language-server = {
        bash-ls = {
          command = "${pkgs.bash-language-server}/bin/bash-language-server";
        };
        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
        };
        css-ls = {
          command = "${pkgs.vscode-langservers-extracted}/bin/css-languageserver";
        };
        docker-compose-ls = {
          command = "${pkgs.docker-compose-language-service}/bin/docker-compose-language-service";
        };
        docker-ls = {
          command = "${pkgs.dockerfile-language-server-nodejs}/bin/dockerfile-language-server-nodejs";
        };
        erlang-ls = {
          command = "${pkgs.erlang-ls}/bin/erlang-ls";
        };
        gopl = {
          command = "${pkgs.gopls}/bin/gopls";
        };
        html-ls = {
          command = "${pkgs.vscode-langservers-extracted}/bin/html-languageserver";
        };
        hypr-ls = {
          command = "${pkgs.hyprls}/bin/hyprls";
        };
        jdtls = {
          command = "${pkgs.jdt-language-server}/bin/jdt-language-server";
        };
        ts-ls = {
          command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
        };
        json-ls = {
          command = "${pkgs.vscode-langservers-extracted}/bin/json-languageserver";
        };
        lua-lsp = {
          command = "${pkgs.lua-language-server}/bin/lua-language-server";
        };
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
        };
        mesonlsp = {
          command = "${pkgs.mesonlsp}/bin/mesonlsp";
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          config.formatting.command = "alejandra";
        };
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
        intelephense = {
          command = "${pkgs.intelephense}/bin/intelephense";
        };
        ruff = {
          command = "${pkgs.ruff}/bin/ruff";
        };
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        };
        svelte-ls = {
          command = "${pkgs.svelte-language-server}/bin/svelte-language-server";
        };
        terraform-ls = {
          command = "${pkgs.terraform-ls}/bin/terraform-ls";
        };
        vue-ls = {
          command = "${pkgs.vue-language-server}/bin/vue-language-server";
        };
        yaml-ls = {
          command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
        };
        zig-ls = {
          command = "${pkgs.zls}/bin/zls";
        };
      };
    };
  };
}
