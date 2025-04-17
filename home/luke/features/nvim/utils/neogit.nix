{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neogit<CR>";
        options = {
          silent = true;
          desc = "Neogit";
        };
      }
    ];
  };
}
