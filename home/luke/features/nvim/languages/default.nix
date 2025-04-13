{pkgs, ...}: {
  imports = [
    ./cpp
    ./csharp
    ./golang
    ./java
    ./lua
    ./nix
    ./php
    ./python
    ./rust
    ./typescript
    ./misc/css.nix
    ./misc/html.nix
    ./misc/json.nix
    ./misc/just.nix
    ./misc/latex.nix
    ./misc/markdown.nix
    ./misc/shell.nix
    ./misc/sql.nix
    ./misc/terraform.nix
    ./misc/toml.nix
    ./misc/typst.nix
    ./misc/yaml.nix
  ];

  programs.nixvim.plugins = {
    #Formatter and Diagnostics
    none-ls.enable = true;

    # Format on Save, ...
    conform-nvim = {
      enable = true;
      package = pkgs.vimPlugins.conform-nvim;
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notify_on_error = true;
      };
      settings.formatters_by_ft = {
        "_" = ["trim_whitespace"];
      };
    };

    # Generic LSP Server Setup
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        diagnostic = {
          "<leader>E" = "open_float";
          "[" = "goto_prev";
          "]" = "goto_next";
        };
        lspBuf = {
          "gD" = "declaration";
          "gd" = "definition";
          "gr" = "references";
          "gI" = "implementation";
          "gy" = "type_definition";
          "<leader>h" = "hover";
          "<leader>f" = "format";
          "<leader>ca" = "code_action";
          "<leader>cr" = "rename";
          "<leader>cD" = "declaration";
          "<leader>cd" = "definition";
          "<leader>cR" = "references";
          "<leader>cI" = "implementation";
          "<leader>cy" = "type_definition";
          "<leader>wl" = "list_workspace_folders";
          "<leader>wr" = "remove_workspace_folder";
          "<leader>wa" = "add_workspace_folder";
        };
      };
      preConfig =
        # lua
        ''
          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {border = 'rounded'}
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {border = 'rounded'}
          )
        '';
      postConfig =
        # lua
        ''
          vim.diagnostic.config {
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = " ",
              },
              numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
              },
            },
          }
        '';
    };
  };
}
