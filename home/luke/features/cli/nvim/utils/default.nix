{pkgs, ...}: {
  imports = [
    ./compiler.nix
    ./dadbod.nix
    ./dap.nix
    ./emmet.nix
    ./gx.nix
    ./kommentary.nix
    ./oil.nix
    ./remote-nvim.nix
    ./toggleterm.nix
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
