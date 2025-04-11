{
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps = {
      next.key = "<C-l>";
      previous.key = "<C-h>";
      close.key = "<C-w>";
    };
  };
}
