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
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });

    settings.primary = {
      exclusive = false;
      layer = "bottom";
      passthrough = false;
      height = 40;
      margin = "6";
      position = "top";
    };
  };
}
