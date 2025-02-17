{pkgs, ...}:{

  imports = [
    ./layout.nix
    ./modules.nix
    ./style.nix
  ];

  systemd.user.services.waybar = {Unit.StartLimitBurst = 30;};
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.primary = {
      exclusive = false;
      layer = "top";
      passthrough = false;
      mode = "dock";
      height = 40;
      margin = "6";
      position = "top";
    };
  };
}
