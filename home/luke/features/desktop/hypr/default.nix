{
  lib,
  config,
  pkgs,
  outputs,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";

  primary = rgb config.colorscheme.colors.primary;
  tertiary = rgb config.colorscheme.colors.tertiary;
  surface = rgb config.colorscheme.colors.surface;
  on_surface = rgb config.colorscheme.colors.on_surface;
  primary_alpha = rgba config.colorscheme.colors.primary "cc";
  tertiary_alpha = rgba config.colorscheme.colors.tertiary "cc";
  surface_alpha = rgba config.colorscheme.colors.surface "cc";
in {
  imports = [
    ../common
    ../wayland
    ./binds.nix
    ./decorations.nix
    ./windowrules.nix

    # Plugins
    ./plugin/hyprgrass.nix
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

  home.packages = with pkgs;[hyprland-qtutils];

  programs = {
    museeks.enable = true;
    hyprpicker.enable = true;
    hyprshot.enable = true;
  };

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

    settings = let
      active_border = "${primary}";
      inactive_border = "${surface}";
    in {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = true;
        "col.active_border" = active_border;
        "col.inactive_border" = inactive_border;
      };
      cursor.inactive_timeout = 4;
      group = {
        "col.border_active" = active_border;
        "col.border_inactive" = inactive_border;
        "col.border_locked_active" = active_border;
        "col.border_locked_inactive" = inactive_border;
        groupbar = {
          height = 16;
          font_size = 12;
          gradients = true;
          text_color = on_surface;
          "col.active" = primary_alpha;
          "col.inactive" = surface_alpha;
          "col.locked_active" = tertiary_alpha;
          "col.locked_inactive" = surface_alpha;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_cancel_ratio = 0.15;
        workspace_swipe_fingers = 2;
      };
      binds = {
        movefocus_cycles_fullscreen = false;
      };
      input = {
        kb_layout = "de";
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };
      dwindle = {
        split_width_multiplier = 1.35;
        pseudotile = true;
      };
      misc = {
        vfr = true;
        close_special_on_empty = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      exec = [
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
      ];

      monitor = let
        waybarSpace = let
          inherit
            (config.wayland.windowManager.hyprland.settings.general)
            gaps_in
            gaps_out
            ;
          inherit
            (config.programs.waybar.settings.primary)
            position
            height
            width
            ;
          gap = gaps_out - gaps_in;
        in {
          top =
            if (position == "top")
            then height + gap
            else 0;
          bottom =
            if (position == "bottom")
            then height + gap
            else 0;
          left =
            if (position == "left")
            then width + gap
            else 0;
          right =
            if (position == "right")
            then width + gap
            else 0;
        };
      in
        [
          ",addreserved,${toString waybarSpace.top},${
            toString waybarSpace.bottom
          },${toString waybarSpace.left},${toString waybarSpace.right}"
        ]
        ++ (map (m: "${m.name},${
          if m.enabled
          then "${toString m.width}x${toString m.height}@${
            toString m.refreshRate
          },${toString m.x}x${toString m.y} , 1, transform, ${toString m.orientation}"
          else "disable"
        }") (config.monitors));

      workspace =
        map (m: "name:${m.workspace},monitor:${m.name}")
        (lib.filter (m: m.enabled && m.workspace != null) config.monitors);
    };

    # This is order sensitive, so it has to come here.
    extraConfig = ''
      # Passthrough mode (e.g. for VNC)
      bind=SUPER,P,submap,passthrough
      submap=passthrough
      bind=SUPER,P,submap,reset
      submap=reset

      # environment
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
