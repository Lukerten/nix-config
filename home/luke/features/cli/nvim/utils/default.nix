{pkgs, ...}: {
  imports = [
    ./dap.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-illuminate
    vim-numbertoggle
    {
      plugin = vim-bbye;
      type = "lua";
      config =
        # lua
        ''
          vim.keymap.set("n", "q", "<cmd>Bdelete<cr>", default_opts("Close Buffer"))
        '';
    }
    {
      plugin = nvim-bqf;
      type = "lua";
      config =
        # lua
        ''
          require('bqf').setup{}
        '';
    }
    {
      plugin = scope-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('scope').setup{}
        '';
    }
    {
      plugin = pkgs.vimPlugins.gx-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('gx').setup{}
          vim.keymap.set("v", "<leader>b", ":Browse<cr>", default_opts("Browse Selection"))
        '';
    }
    {
      plugin = pkgs.vimPlugins.kommentary;
      type = "lua";
      config =
        # lua
        ''
          require("kommentary.config").configure_language("default", {
            prefer_single_line_comments = true,
            use_consistent_indentation = true,
            ignore_whitespace = true,
          })

          vim.keymap.set("v", "<leader>c", "<Plug>kommentary_visual_default", default_opts("Comment Lines"))
        '';
    }
    {
      plugin = pkgs.vimPlugins.presence-nvim;
      type = "lua";
      config =
        # lua
        ''
          require("presence").setup({
            auto_update         = true,
            neovim_image_text   = "The One True Text Editor",
            main_image          = "neovim",
            client_id           = "793271441293967371",
            log_level           = nil,
            debounce_timeout    = 10,
            enable_line_number  = false,
            blacklist           = {},
            buttons             = true,
            file_assets         = {},
            show_time           = true,
            editing_text        = "Editing %s",
            file_explorer_text  = "Browsing %s",
            git_commit_text     = "Committing changes",
            plugin_manager_text = "Managing plugins",
            reading_text        = "Reading %s",
            workspace_text      = "Working on %s",
            line_number_text    = "Line %s out of %s",
          })
        '';
    }
  ];
}
