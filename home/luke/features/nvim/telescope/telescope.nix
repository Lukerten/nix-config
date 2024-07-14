{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    telescope-project-nvim
    {
      plugin = project-nvim;
      type = "lua";
      config = # lua
        ''
          require("project_nvim").setup {
            active = true,
            on_config_done = nil,
            manual_mode = false,
            detection_methods = { "pattern" },
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
            show_hidden = false,
            silent_chdir = true,
            ignore_lsp = {},
            datapath = vim.fn.stdpath("data"),
          }
          -- require("telescope").load_extensions('project_nvim')
        '';
    }
    {
      plugin = telescope-nvim;
      type = "lua";
      config = # lua
        ''
          require("telescope").setup {
            defaults = {
              vimgrep_arguments = {
                "${pkgs.ripgrep}/bin/rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
              },
              pickers = {
                find_command = {
                  "${pkgs.fd}/bin/fd",
                },
              },
            }
          }
        '';
    }
  ];
}
