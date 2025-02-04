{pkgs, ...}: let
  # Telescope
  telescope-package = pkgs.vimPlugins.telescope-nvim;
  telescope-config = ''
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
    vim.keymap.set("n", "<leader><space>", "<cmd>Telescope find_files<cr>", default_opts("Search files"))
    vim.keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>", default_opts("Live grep"))
    vim.keymap.set("n", "<leader>Sh", "<cmd>Telescope help_tags<cr>", default_opts("Help tags"))
    vim.keymap.set("n", "<leader>Sm", "<cmd>Telescope man_pages<cr>", default_opts("Man Pages"))
    vim.keymap.set("n", "<leader>So", "<cmd>Telescope oldfiles<cr>", default_opts("Old files"))
    vim.keymap.set("n", "<leader>Sr", "<cmd>Telescope registers<cr>", default_opts("Registers"))
    vim.keymap.set("n", "<leader>Sk", "<cmd>Telescope keymaps<cr>", default_opts("Keymaps"))
    vim.keymap.set("n", "<leader>Sc", "<cmd>Telescope commands<cr>", default_opts("Commands"))
    vim.keymap.set("n", "<leader>SGs", "<cmd>Telescope git_status<cr>",default_opts("Git Status"))
    vim.keymap.set("n", "<leader>SGb", "<cmd>Telescope git_branches<cr>",default_opts("Git Branches"))
    vim.keymap.set("n", "<leader>SGc", "<cmd>Telescope git_commits<cr>",default_opts("Git Commits"))
  '';

  # Project.nvim
  project-package = pkgs.vimPlugins.project-nvim;
  project-config = ''
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

  # Telescope project extension
  telescope-project-package = pkgs.vimPlugins.telescope-project-nvim;
in {
  programs.neovim.plugins = [
    {
      plugin = telescope-package;
      config = telescope-config;
      type = "lua";
    }
    {
      plugin = project-package;
      config = project-config;
      type = "lua";
    }
    telescope-project-package
  ];
}
