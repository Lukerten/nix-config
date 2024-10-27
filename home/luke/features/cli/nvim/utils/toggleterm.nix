{pkgs, ...}: let
  package = pkgs.vimPlugins.toggleterm-nvim;
  config =
    #lua
    ''
      require("toggleterm").setup({
        size = 20;
        open_mapping = [[<C-%]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      -- Set key mappings in normal and visual mode for ToggleTerm
      vim.keymap.set("n", "<space>t", '<cmd>ToggleTerm direction=horizontal name="Dev Console"<CR>', default_opts("Open Terminal"))
      vim.keymap.set("v", "<space>t", '<cmd>ToggleTerm direction=horizontal name="Dev Console"<CR>', default_opts("Open Terminal"))
      vim.keymap.set("n", "<space>Tv", '<cmd>ToggleTerm direction=vertical name="Dev Console"<CR>', default_opts("Open Terminal"))
      vim.keymap.set("v", "<space>Tv", '<cmd>ToggleTerm direction=vertical name="Dev Console"<CR>', default_opts("Open Terminal"))
      vim.keymap.set("n", "<space>Tf", '<cmd>ToggleTerm<CR>', default_opts("Open Terminal"))
      vim.keymap.set("v", "<space>Tf", '<cmd>ToggleTerm<CR>', default_opts("Open Terminal"))
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
