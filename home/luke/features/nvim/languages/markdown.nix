{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lsp.servers.marksman.enable = true;
      none-ls.sources.formatting.prettier.enable = true;
      conform-nvim.settings.formatters_by_ft.markdown = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        stop_after_first = true;
      };

      # Snippet Support
      luasnip.fromSnipmate = [
        {
          paths = ../snippets/store/snippets/markdown.snippets;
          include = ["markdown"];
        }
      ];

      markview = {
        enable = true;
        settings = {
          preview = {
            buf_ignore = [];
            hybrid_modes = [
              "i"
            ];
            modes = [
              "n"
              "i"
              "no"
              "c"
            ];
            callbacks.on_enable.__raw = ''
              function(_, win)
                vim.wo[win].conceallevel = 2
                vim.wo[win].concealcursor = "nc"
              end
            '';
          };
        };
      };
    };
  };
}
