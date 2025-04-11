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
    ./misc/markdown.nix
    ./misc/shell.nix
    ./misc/sql.nix
    ./misc/terraform.nix
    ./misc/toml.nix
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
          "<leader>do" = "setloclist";
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
          vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            float = {
              border = 'rounded',
              source = 'always',
            },
          })

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
          local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
          end
        '';
    };
  };
}
