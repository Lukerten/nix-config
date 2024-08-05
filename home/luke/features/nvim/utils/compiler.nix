{pkgs, ...}:
let
    overseer = pkgs.vimPlugins.overseer-nvim;
    overseer-config = # lua
    ''
      local overseer = require('overseer')
      overseer.setup();
    '';
    compiler = pkgs.vimPlugins.compiler-nvim;
    compiler-config = # lua
    ''
      local compiler = require('compiler')
      compiler.setup();

      vim.api.nvim_set_keymap('n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
      -- Redo last selected option
      vim.api.nvim_set_keymap('n', '<S-F6>',
          "<cmd>CompilerStop<cr>"
        .."<cmd>CompilerRedo<cr>",
        { noremap = true, silent = true })
      -- Toggle compiler results
      vim.api.nvim_set_keymap('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
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
