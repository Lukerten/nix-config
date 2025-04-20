{
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = true;
    settings = {
      sign = {
        enabled = true;
        text = "󰌶";
      };
      virtual_text = {
        enabled = false;
        text = "󰌶";
      };
      float = {
        enabled = false;
        text = " 󰌶 ";
      };
      status_text = {
        enabled = false;
        text = " 󰌶 ";
      };
      number = {
        enabled = false;
      };
      line = {
        enabled = false;
      };
      autocmd = {
        enabled = true;
        updatetime = 200;
      };
    };
  };
}
