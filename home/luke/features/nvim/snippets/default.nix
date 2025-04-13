{
  programs.nixvim.plugins = {
    # Friendly Snippets
    friendly-snippets = {
      enable = true;
    };

    # Code snippets
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
    };

    # Even more snippets
    nvim-snippets = {
      enable = false;
      settings = {
        create_autocmd = true;
        create_cmp_source = true;
        extended_filetypes = {
          typescript = [
            "javascript"
          ];
        };
        friendly_snippets = true;
        global_snippets = [
          "all"
        ];
        ignored_filetypes = [
          #  "lua"
        ];
        search_paths = [
          {
            __raw = "vim.fn.stdpath('config') .. '/snippets'";
          }
        ];
      };
    };
  };
}
