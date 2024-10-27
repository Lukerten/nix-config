{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = trouble-nvim;
      type = "lua";
      config =
        # lua
        ''
          -- Enable trouble diagnostics viewer
          require("trouble").setup()

          -- Trouble
          vim.keymap.set("n", "<space>Tt", "<cmd>Trouble diagnostics toggle<CR>",default_opts("Toggle diagnostics"))
          vim.keymap.set("n", "<space>Td", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",default_opts("Workspace diagnostics"))
          vim.keymap.set("n", "<space>Ts", "<cmd>Trouble symbols togglefocus=false<CR>",default_opts("LSP symbols"))
          vim.keymap.set("n", "<space>Tl", "<cmd>Trouble loclist toggle<CR>",default_opts("loclist"))
          vim.keymap.set("n", "<space>Tq", "<cmd>Trouble qflist toggle<CR>",default_opts("quickfix list"))
        '';
    }
  ];
}
