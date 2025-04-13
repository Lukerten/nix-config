{
  imports = [
    ./diagnostics.nix
    ./keys.nix
    ./theme.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;

      termguicolors = true;
      signcolumn = "yes";
      mouse = "a";

      ignorecase = true;
      smartcase = true;

      splitright = true;
      splitbelow = true;

      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      encoding = "utf-8";
      fileencoding = "utf-8";

      undofile = true;
      swapfile = false;
      backup = false;
      autoread = true;

      # Highlight the current line for cursor
      cursorline = true;

      # Show line and column when searching
      ruler = true;

      # Global substitution by default
      gdefault = true;
      scrolloff = 5;
      updatetime = 100; # Faster completion

      foldenable = false;
      autoindent = true;
      breakindent = true;
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;

      incsearch = true;
      wildmode = "list:longest";
    };

    globals.mapleader = " ";
  };
}
