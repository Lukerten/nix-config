{
  imports = [
    ./git-worktree.nix
    ./neogit.nix
    ./neorg.nix
  ];

  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;
      vim-surround.enable = true;
      undotree.enable = true;
      bufdelete.enable = true;

      todo-comments = {
        enable = true;
        keymaps = {
          todoTelescope = {
            key = "<leader>sT";
            keywords = ["TODO"];
          };
        };
      };
    };
    keymaps = [
      # Bufferdelete
      {
        key = "<leader>x";
        action = ":Bdelete <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Delete buffer";
        };
      }
      # Undotree
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>UndotreeToggle<CR>";
        options = {
          desc = "Undotree";
        };
      }
    ];
  };
}
