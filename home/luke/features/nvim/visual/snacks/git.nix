{
  programs.nixvim.plugins.snacks = {
    settings = {
      git = {};
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gb";
      action = ":lua Snacks.git.blame_line()<CR>";
      options = {
        desc = "Blame line";
      };
    }
  ];
}
