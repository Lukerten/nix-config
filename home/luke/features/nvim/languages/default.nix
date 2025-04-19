{pkgs, ...}: {
  imports = [
    ./cpp.nix
    ./csharp.nix
    ./golang.nix
    ./css.nix
    ./html.nix
    ./java.nix
    ./json.nix
    ./just.nix
    ./kotlin.nix
    ./latex.nix
    ./lua.nix
    ./markdown.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./sql.nix
    ./terraform.nix
    ./toml.nix
    ./typescript.nix
    ./typst.nix
    ./yaml.nix
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
          "<leader>Cf" = "format";
          "<leader>Ca" = "code_action";
          "<leader>Cr" = "rename";
          "<leader>CD" = "declaration";
          "<leader>Cd" = "definition";
          "<leader>CR" = "references";
          "<leader>CI" = "implementation";
          "<leader>Cy" = "type_definition";
          "<leader>Wl" = "list_workspace_folders";
          "<leader>Wr" = "remove_workspace_folder";
          "<leader>Wa" = "add_workspace_folder";
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
