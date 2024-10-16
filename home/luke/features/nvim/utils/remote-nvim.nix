{pkgs, ...}: let
  package = pkgs.vimPlugins.remote-nvim;
  config =
    #lua
    ''
      utils = require("remote-nvim.utils")
      constants = require("remote-nvim.constants")
      require("remote-nvim").setup{
        devpod = {
          binary = "${pkgs.devpod}/bin/devpod",
          docker_binary = "${pkgs.docker}/bin/docker",
          ssh_config_path = utils.path_join(utils.is_windows, vim.fn.stdpath("data"), constants.PLUGIN_NAME, "ssh_config"),
          search_style = "current_dir_only",
          dotfiles = {
              path = nil,
              install_script = nil
          },
          gpg_agent_forwarding = false,
          container_list = "running_only",
        },

        ssh_config = {
          ssh_binary = "${pkgs.openssh}/bin/ssh",
          scp_binary = "${pkgs.openssh}/bin/scp",
          ssh_config_file_paths = { "$HOME/.ssh/config" },
          ssh_prompts = {
            {
              match = "password:",
              type = "secret",
              value_type = "static",
              value = "",
            },
            {
              match = "continue connecting (yes/no/[fingerprint])?",
              type = "plain",
              value_type = "static",
              value = "yes",
            },
          },
        },

        progress_view = {
          type = "popup",
        },

        offline_mode = {
          enabled = false,
          no_github = false,
        },

        -- Path to the script that would be copied to the remote and called to ensure that neovim gets installed.
        -- Default path is to the plugin's own ./scripts/neovim_install.sh file.
        neovim_install_script_path = utils.path_join(
          utils.is_windows,
          vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h:h:h"),
          "scripts",
          "neovim_install.sh"
          ),

        remote = {
          app_name = "nvim",
          copy_dirs = {
            config = {
              base = vim.fn.stdpath("config"),
              dirs = "*",
              compression = {
                enabled = false,
                additional_opts = {}
              },
            },
            data = {
              base = vim.fn.stdpath("data"),
              dirs = {},
              compression = {
                enabled = true,
              },
            },
            cache = {
              base = vim.fn.stdpath("cache"),
              dirs = {},
              compression = {
                enabled = true,
              },
            },
            state = {
              base = vim.fn.stdpath("state"),
              dirs = {},
              compression = {
                enabled = true,
              },
            },
          },
        },
      }
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = package;
      type = "lua";
      config = config;
    }
  ];
}
