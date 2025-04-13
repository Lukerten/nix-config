{
  programs.nixvim.plugins = {
    conform-nvim = {
      settings.formatters_by_ft = {
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
      };
    };
    lsp.servers.ts_ls = {
      enable = true;
      filetypes = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
      ];
      extraOptions = {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          };
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          };
        };
      };
    };
    lsp.servers.eslint.enable = true;
    none-ls.sources.formatting.prettier.disableTsServerFormatter = false;
    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/javascript/javascript.snippets;
        include = ["javascript"];
      }
      {
        paths = ../../snippets/store/snippets/javascript/javascript-react.snippets;
        include = ["javascript-react"];
      }
      {
        paths = ../../snippets/store/UltiSnips/javascript-node.snippets;
        include = ["javascript-node"];
      }
      {
        paths = ../../snippets/store/snippets/typescript.snippets;
        include = ["typescript"];
      }
      {
        paths = ../../snippets/store/snippets/typescriptreact.snippets;
        include = ["typescript-react"];
      }
    ];
  };
}
