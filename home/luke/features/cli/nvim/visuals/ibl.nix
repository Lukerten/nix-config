{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config =
        # lua
        ''
          vim.opt.list = true
          local hooks = require "ibl.hooks"
          require("ibl").setup {
            -- indent = { highlight = highlight, char = "|" },
            indent = {
              highlight = highlight,
              char = "▏",
              tab_char = "▏",
            },
            whitespace = {
              highlight = highlight,
              remove_blankline_trail = true,
            },
            scope = {
              show_start = true,
              show_end = true,
            },
          }
        '';
    }
  ];
}
