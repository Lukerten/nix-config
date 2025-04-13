{
  programs.nixvim.plugins.presence-nvim = {
    enable = true;
    autoUpdate = true;
    logLevel = null;
    debounceTimeout = 10;
    enableLineNumber = false;
    neovimImageText = "The One True Text Editor";
    editingText = "Editing %s";
    fileExplorerText = "Browsing %s";
    gitCommitText = "Committing changes";
    pluginManagerText = "Managing plugins";
    readingText = "Reading %s";
    workspaceText = "Working on %s";
    lineNumberText = "Line %s out of %s";
  };
}
