{
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;

      disableNetrw = false;
      hijackNetrw = true;
      openOnSetup = true;
      autoClose = true;
      diagnostics.enable = true;
      view = {
        width = 40;
        side = "left";
        number = false;
        relativenumber = false;
      };
      renderer = {
        indentMarkers.enable = true;
        addTrailing = true;
        groupEmpty = true;
        highlightGit = true;

        rootFolderLabel = ":t";
      };
      hijackDirectories = {
        enable = true;
        autoOpen = true;
      };
      updateFocusedFile = {
        enable = true;
        ignoreList = [];
      };
      actions = {
        useSystemClipboard = true;
        changeDir.enable = true;
        openFile.quitOnOpen = true;
        openFile.resizeWindow = false;
      };
      git = {
        enable = true;
        ignore = false;
      };
      filters = {
        dotfiles = false;
        custom = [
          ".trash"
          ".direnv"
        ];
      };
    };
    keymaps = [
      {
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "NvimTree";
        };
      }
    ];
  };
}
