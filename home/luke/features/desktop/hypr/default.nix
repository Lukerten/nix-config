{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../wayland
    # Hyprland
    ./binds.nix
    ./decorations.nix
    ./generic.nix
    ./windowrules.nix
    ./plugin/hypridle.nix
    ./plugin/hyprlock.nix
    ./plugin/hyprpaper.nix
  ];

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [xdph];
    configPackages = [hyprland];
  };

  home.packages = with pkgs; [
    hyprland-qtutils
    grimblast
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap (pkgs.hyprland.override {
      wrapRuntimeDeps = false;
    });
    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
      variables = [
        "DISPLAY"
        "HYPRLAND_INSTANCE_SIGNATURE"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
      ];
    };

    extraConfig = ''
      bind=SUPERSHIFT,P,submap,passthrough
      bind=SUPERSHIFT,P,submap,reset
      submap=passthrough
      submap=reset
      # Environment variables
      env = XDG_CURRENT_DESKTOP=Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = QT_QPA_PLATFORM,wayland
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = GDK_BACKEND,wayland,x11,*
      env = QT_QPA_PLATFORM,wayland;xcb
      env = SDL_VIDEODRIVER,wayland
      env = CLUTTER_BACKEND,wayland
    '';
  };
}
