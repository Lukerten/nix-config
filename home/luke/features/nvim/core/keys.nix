let
  mkOption = desc: {
    inherit desc;
    silent = true;
    noremap = true;
  };
in {
  programs.nixvim.keymaps = [
    # Window Navigation:
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-e>";
      options = mkOption "Scroll Down";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<C-e>";
      options = mkOption "Scroll Down";
    }

    {
      mode = "n";
      key = "<C-k>";
      action = "<C-y>";
      options = mkOption "Scroll up";
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<C-e>";
      options = mkOption "Scroll Down";
    }

    # Buffers
    {
      mode = "n";
      key = "<C-l>";
      action = "<cmd>bnext<cr>";
      options = mkOption "Next Buffer";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>bprev<cr>";
      options = mkOption "Prev Buffer";
    }

    # Make
    {
      mode = "n";
      key = "<leader>m";
      action = "<cmd>make";
      options.desc = "Make";
    }

    # Move Lines
    {
      mode = "n";
      key = "K";
      action = "<cmd>m .-2<cr>==";
      options = mkOption "Move Line up";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options = mkOption "Move Line up";
    }
    {
      mode = "n";
      key = "J";
      action = "<cmd>m .+1<CR>==";
      options = mkOption "Move line down";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options = mkOption "Move line down";
    }

    # use System Copy/paste
    {
      mode = "n";
      key = "<leader>y";
      action = "\"+yy ";
      options = mkOption "Copy to System Clipboard";
    }
    {
      mode = "v";
      key = "<leader>y";
      action = "\"+y ";
      options = mkOption "Copy to System Clipboard";
    }
    {
      mode = "n";
      key = "<leader>p";
      action = "\"+p ";
      options = mkOption "Paste from System Clipboard";
    }
    {
      mode = "v";
      key = "<leader>p";
      action = "\"+p ";
      options = mkOption "Paste from System Clipboard";
    }
  ];
}
