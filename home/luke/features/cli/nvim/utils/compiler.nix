{pkgs, ...}: let
  overseer = pkgs.vimPlugins.overseer-nvim;
  overseer-config =
    # lua
    ''
      local overseer = require('overseer')
      overseer.setup();
    '';
  compiler = pkgs.vimPlugins.compiler-nvim;
  compiler-config =
    # lua
    ''
      local compiler = require('compiler')
      compiler.setup();

      vim.api.nvim_set_keymap('n', '<F6>', "<cmd>CompilerOpen<cr>", default_opts("Open Runner"))
      vim.api.nvim_set_keymap('n', '<leader>c', "<cmd>CompilerOpen<cr>", default_opts("Open Runner"))
      -- Redo last selected option
      vim.api.nvim_set_keymap('n', '<S-F6>',
          "<cmd>CompilerStop<cr>"
        .."<cmd>CompilerRedo<cr>",
        default_opts("Rerun last configuration"))

      -- Toggle compiler results
      vim.api.nvim_set_keymap('n', '<F5>', "<cmd>CompilerToggleResults<cr>", default_opts("Toggle results"))
    '';
in {
  programs.neovim = {
    plugins = [
      {
        plugin = overseer;
        config = overseer-config;
        type = "lua";
      }
      {
        plugin = compiler;
        config = compiler-config;
        type = "lua";
      }
    ];
  };
}
