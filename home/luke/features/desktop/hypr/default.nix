{
  lib,
  config,
  pkgs,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";

  primary = rgb config.colorscheme.colors.primary;
  surface = rgb config.colorscheme.colors.surface;
  on_surface = rgb config.colorscheme.colors.on_surface;
  primary_alpha = rgba config.colorscheme.colors.primary "cc";
  tertiary_alpha = rgba config.colorscheme.colors.tertiary "cc";
  surface_alpha = rgba config.colorscheme.colors.surface "cc";
in {
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
    package = pkgs.hyprland.override {wrapRuntimeDeps = false;};
    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
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
