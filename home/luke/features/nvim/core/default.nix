{
  imports = [
    ./keys.nix
    ./theme.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;

      termguicolors = true;
      completeopt = ["menuone" "noselect" "noinsert"];
      signcolumn = "yes";

      mouse = "a";

      ignorecase = true;
      smartcase = true;

      splitright = true;
      splitbelow = true;

      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      clipboard = {
        providers = {
          wl-copy.enable = true; # Wayland
          xsel.enable = true; # For X11
        };
        register = "unnamedplus";
      };

      # Set encoding
      encoding = "utf-8";
      fileencoding = "utf-8";

      # Save undo history
      undofile = true;
      swapfile = true;
      backup = false;
      autoread = true;

      # Highlight the current line for cursor
      cursorline = true;

      # Show line and column when searching
      ruler = true;
      foldenable = false;

      # Global substitution by default
      gdefault = true;
      scrolloff = 5;
      updatetime = 100; # Faster completion

      autoindent = true;
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;

      incsearch = true;
      wildmode = "list:longest";
    };

    diagnostics = {
      update_in_insert = true;
      severity_sort = true;
      float = {
        border = "rounded";
      };
      jump = {
        severity.__raw = "vim.diagnostic.severity.WARN";
      };
    };

    globals.mapleader = " ";
  };
}
