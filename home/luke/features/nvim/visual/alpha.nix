{
  lib,
  config,
  ...
}:
with lib; let
  mkButtonOpts = shortcut: {
    inherit shortcut;
    position = "center";
    hl = "Number";
    width = 50;
    align_shortcut = "right";
    hl_shortcut = "Keyword";
  };
  hasDadbod = config.programs.nixvim.plugins.vim-dadbod-ui.enable;
  hasTodoComment = config.programs.nixvim.plugins.todo-comments.enable;
  hasTelescope = config.programs.nixvim.plugins.telescope.enable;
  hasTelescopeProject = config.programs.nixvim.plugins.telescope.extensions.project.enable;
  hasNeoGit = config.programs.nixvim.plugins.neogit.enable;
  hasNeorg = config.programs.nixvim.plugins.neorg.enable;
  hasRemoteNvim = config.programs.nixvim.plugins.remote-nvim.enable;
in {
  programs.nixvim.plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 2;
      }
      {
        type = "text";
        val = [
          "                                   "
          "                                   "
          "                                   "
          "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
          "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
          "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
          "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
          "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
          "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
          "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
          " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
          " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
          "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
          "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
          "                                   "
        ];
        opts = {
          position = "center";
          hl = "Title";
        };
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val =
          [
            {
              type = "button";
              val = "  New file";
              on_press.__raw = "function() vim.cmd[[ene]] end";
              opts = mkButtonOpts "n";
            }
          ]
          ++ optionals hasTelescopeProject [
            {
              type = "button";
              val = "  Find project";
              on_press.__raw = "function() vim.cmd[[Telescope project]] end";
              opts = mkButtonOpts "p";
            }
          ]
          ++ optionals hasTelescope [
            {
              type = "button";
              val = "  Find files";
              on_press.__raw = "function() vim.cmd[[Telescope find_files]] end";
              opts = mkButtonOpts "f";
            }
            {
              type = "button";
              val = "󱎸  Find text";
              on_press.__raw = "function() vim.cmd[[Telescope live_grep]] end";
              opts = mkButtonOpts "g";
            }
          ]
          ++ optionals (hasTodoComment
            && hasTelescope) [
            {
              type = "button";
              val = "󰅚  Find todos";
              on_press.__raw = "function() vim.cmd[[TodoTelescope]] end";
              opts = mkButtonOpts "t";
            }
          ]
          ++ optionals hasDadbod [
            {
              type = "button";
              val = "󰒋  DB UI";
              on_press.__raw = "function() vim.cmd[[DBUI]] end";
              opts = mkButtonOpts "d";
            }
          ]
          ++ optionals hasNeoGit [
            {
              type = "button";
              val = "  Neogit";
              on_press.__raw = "function() vim.cmd[[Neogit]] end";
              opts = mkButtonOpts "s";
            }
          ]
          ++ optionals hasRemoteNvim [
            {
              type = "button";
              val = "󰒉  Remote Nvim";
              on_press.__raw = "function() vim.cmd[[RemoteStart]] end";
              opts = mkButtonOpts "r";
            }
          ]
          ++ optionals hasNeorg [
            {
              type = "button";
              val = "󰍉  Neorg";
              on_press.__raw = "function() vim.cmd[[Neorg index]] end";
              opts = mkButtonOpts "o";
            }
          ]
          ++ [
            {
              type = "button";
              val = "  Quit Neovim";
              on_press.__raw = "function() vim.cmd[[qa]] end";
              opts = mkButtonOpts "q";
            }
          ];
        opts = {
          spacing = 1;
        };
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "text";
        val = "Inspiring quote here.";
        opts = {
          position = "center";
          hl = "Title";
        };
      }
    ];
  };
}
