{
  lib,
  config,
  pkgs,
  outputs,
  ...
}: let
  opacity_inactive = 0.80;
  opacity_active = 0.80;
  opacity_fullscreen = 1.0;

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
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [xdph];
    configPackages = [hyprland];
  };

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
      windowrulev2 = let
        sweethome3d-tooltips = "title:win[0-9],class:com-eteks-sweethome3d-SweetHome3DBootstrap";
        xembedsniproxy = "class:,title:,xwayland:1,floating:1";
        steam = "title:,class:steam";
        steamGame = "class:steam_app_[0-9]*";
        kdeconnect-pointer = "class:org.kdeconnect.daemon";
        wineTray ="class:explorer.exe";
        rsiLauncher ="class:rsi launcher.exe";
      in
        [
          "nofocus, ${sweethome3d-tooltips}"
          "stayfocused, ${steam}"
          "minsize 1 1, ${steam}"
          "immediate, ${steamGame}"
          "size 100% 100%, ${kdeconnect-pointer}"
          "float, ${kdeconnect-pointer}"
          "nofocus, ${kdeconnect-pointer}"
          "noblur, ${kdeconnect-pointer}"
          "noanim, ${kdeconnect-pointer}"
          "noshadow, ${kdeconnect-pointer}"
          "noborder, ${kdeconnect-pointer}"
          "plugin:hyprbars:nobar, ${kdeconnect-pointer}"
          "suppressevent fullscreen, ${kdeconnect-pointer}"
          "noblur, ${xembedsniproxy}"
          "opacity 0, ${xembedsniproxy}"
          "workspace special silent, ${xembedsniproxy}"
          "noinitialfocus, ${xembedsniproxy}"
          "workspace special silent, ${wineTray}"
          "tile, ${rsiLauncher}"
        ];
      layerrule = [
        "animation fade,hyprpicker"
        "animation fade,selection"
        "animation fade,waybar"
        "blur,waybar"
        "ignorezero,waybar"
        "blur,notifications"
        "ignorezero,notifications"
        "blur,rofi"
        "ignorezero,rofi"
        "noanim,wallpaper"
      ];

      decoration = {
        active_opacity = opacity_inactive;
        inactive_opacity = opacity_active;
        fullscreen_opacity = opacity_fullscreen;
        rounding = 4;
        blur = {
          enabled = true;
          size = 6;
          passes = 4;
          popups = true;
        };
        shadow = {
          enabled = false;
          range = 12;
          color = "0x44000000";
          color_inactive = "0x66000000";
          offset = "3 3";
          scale = 6;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easein,0.1, 0, 0.5, 0"
          "easeout,0.5, 1, 0.9, 1"
          "easeinout,0.45, 0, 0.55, 1"
        ];

        animation = [
          "fadeIn,1,3,easeout"
          "fadeLayersIn,1,3,easeout"
          "layersIn,1,3,easeout,slide"
          "windowsIn,1,3,easeout,slide"
          "fadeLayersOut,1,3,easein"
          "fadeOut,1,3,easein"
          "layersOut,1,3,easein,slide"
          "windowsOut,1,3,easein,slide"
          "border,1,3,easeout"
          "fadeDim,1,3,easeinout"
          "fadeShadow,1,3,easeinout"
          "fadeSwitch,1,3,easeinout"
          "windowsMove,1,3,easeout"
          "workspaces,1,2.6,easeout,slide"
        ];
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
