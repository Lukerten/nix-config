{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>Gg";
        action = ":Neogit<CR>";
        options = {
          silent = true;
          desc = "Neogit";
        };
      }
    ];
  };
}
