{pkgs, ...}: {
  imports = [
    ./compiler.nix
    ./dap.nix
    ./gx.nix
    ./kommentary.nix
    ./obsidian.nix
    ./oil.nix
    ./vimwiki.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    hunk-nvim
    nui-nvim
    popup-nvim
    vim-illuminate
    nvim-notify
    vim-numbertoggle
    {
      plugin = lazygit-nvim;
      type = "lua";
      config =
        # lua
        ''
          vim.api.nvim_set_keymap('n', '<leader>g', ':LazyGit<CR>', { silent = true })
        '';
    }
    {
      plugin = vim-bbye;
      type = "lua";
      config =
        # lua
        ''
          vim.keymap.set("n", "q", "<cmd>Bdelete<cr>", default_opts("Close Buffer"))
        '';
    }
    {
      plugin = nvim-bqf;
      type = "lua";
      config =
        # lua
        ''
          require('bqf').setup{}
        '';
    }
    {
      plugin = scope-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('scope').setup{}
        '';
    }
  ];
}
