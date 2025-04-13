{
  programs.nixvim.plugins.lspsaga = {
    enable = true;
    beacon.enable = true;
    ui = {
      border = "rounded";
      codeAction = "💡";
    };
    hover = {
      openCmd = "!floorp";
      openLink = "gx";
    };
    diagnostic = {
      borderFollow = true;
      diagnosticOnlyCurrent = false;
      showCodeAction = true;
    };
    symbolInWinbar.enable = true;
    codeAction = {
      extendGitSigns = false;
      showServerName = true;
      onlyInCursor = true;
      numShortcut = true;
      keys = {
        exec = "<CR>";
        quit = [
          "<Esc>"
          "q"
        ];
      };
    };
  };
}
