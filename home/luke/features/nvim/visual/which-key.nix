{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      delay = 200;
      notify = false;
      icons.mappings = false;
      win.border = "single";
      expand = 1;
      keys = {
        Up = " ";
        Down = " ";
        Left = " ";
        Right = " ";
        C = "󰘴 ";
        M = "󰘵 ";
        D = "󰘳 ";
        S = "󰘶 ";
        CR = "󰌑 ";
        Esc = "󱊷 ";
        ScrollWheelDown = "󱕐 ";
        ScrollWheelUp = "󱕑 ";
        NL = "󰌑 ";
        BS = "󰁮";
        Space = "󱁐 ";
        Tab = "󰌒 ";
        F1 = "󱊫";
        F2 = "󱊬";
        F3 = "󱊭";
        F4 = "󱊮";
        F5 = "󱊯";
        F6 = "󱊰";
        F7 = "󱊱";
        F8 = "󱊲";
        F9 = "󱊳";
        F10 = "󱊴";
        F11 = "󱊵";
        F12 = "󱊶";
      };
    };
  };
}
