{
  programs.nixvim = {
    plugins.todo-comments = {
      enable = true;
      settings = {
        opleader.line = "<C-b>";
        toggler.line = "<C-b>";
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "]t";
        action = "<cmd>lua require('todo-comments').jump_next()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next todo comment";
        };
      }
      {
        mode = "n";
        key = "[t";
        action = "<cmd>lua require('todo-comments').jump_prev()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Previous todo comment";
        };
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>TodoTelescope<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Todo Telescope";
        };
      }
    ];
  };
}
