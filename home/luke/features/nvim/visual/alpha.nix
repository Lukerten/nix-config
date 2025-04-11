{
  lib,
  config,
  ...
}:
with lib; let
  mkButtonOpts = shortcut: {
    position = "center";
    hl = "Number";
    shortcut = shortcut;
    width = 50;
    align_shortcut = "right";
    hl_shortcut = "Keyword";
  };
  hasTelescope = config.programs.nixvim.plugins.telescope.enable;
  hasTelescopeProject = config.programs.nixvim.plugins.telescope.extensions.project.enable;
  hasNeoGit = config.programs.nixvim.plugins.neogit.enable;
  hasNeorg = config.programs.nixvim.plugins.neorg.enable;
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
          hl = "Type";
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
          ++ optionals hasNeoGit [
            {
              type = "button";
              val = "  Neogit";
              on_press.__raw = "function() vim.cmd[[Neogit]] end";
              opts = mkButtonOpts "s";
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
