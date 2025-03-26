{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = trouble-nvim;
      type = "lua";
      config =
        # lua
        ''
          -- Trouble
          require("trouble").setup()

          vim.keymap.set("n", "<leader>Ht", "<cmd>Trouble diagnostics toggle<CR>",default_opts("Toggle diagnostics"))
          vim.keymap.set("n", "<leader>Hd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",default_opts("Workspace diagnostics"))
          vim.keymap.set("n", "<leader>Hs", "<cmd>Trouble symbols togglefocus=false<CR>",default_opts("LSP symbols"))
          vim.keymap.set("n", "<leader>Hl", "<cmd>Trouble loclist toggle<CR>",default_opts("loclist"))
          vim.keymap.set("n", "<leader>Hq", "<cmd>Trouble qflist toggle<CR>",default_opts("quickfix list"))
        '';
    }
  ];
}
