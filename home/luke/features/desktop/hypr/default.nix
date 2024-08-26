{
  lib,
  config,
  pkgs,
  outputs,
  ...
}: let
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in {
  imports = [
    ../common
    ../common/wayland
    ./binds.nix
  ];

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [xdph];
    configPackages = [hyprland];
  };

  home.packages = with pkgs; [
    grimblast
    hyprpicker
    psmisc
    wlogout
    ffmpeg_6-full
    wl-screenrec
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override {wrapRuntimeDeps = false;};
    systemd = {
      enable = true;
      # Same as default, but stop graphical-session too
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = {
      general = {
        gaps_in = 8;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = lib.concatStringsSep " " [
          "${rgba config.colorscheme.colors.tertiary "ff"}"
          "${rgba config.colorscheme.colors.primary "ff"}"
          "45deg"
        ];
        "col.inactive_border" = rgba config.colorscheme.colors.surface "00";
      };
      cursor.inactive_timeout = 4;
      group = {
        "col.border_active" = rgba config.colorscheme.colors.primary "aa";
        "col.border_inactive" = rgba config.colorscheme.colors.surface "aa";
        groupbar.font_size = 11;
      };
      binds = {movefocus_cycles_fullscreen = false;};
      input = {
        kb_layout = "de";
        touchpad.disable_while_typing = false;
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
      };
      windowrulev2 = let
        sweethome3d-tooltips = "title:^(win[0-9])$,class:^(com-eteks-sweethome3d-SweetHome3DBootstrap)$";
        steam = "title:^()$,class:^(steam)$";
        kdeconnect-pointer = "class:^(kdeconnect.daemon)$";
      in [
        "nofocus, ${sweethome3d-tooltips}"
        "stayfocused, ${steam}"
        "minsize 1 1, ${steam}"
        "size 100% 110%, ${kdeconnect-pointer}"
        "center, ${kdeconnect-pointer}"
        "nofocus, ${kdeconnect-pointer}"
        "noblur, ${kdeconnect-pointer}"
        "noanim, ${kdeconnect-pointer}"
        "noshadow, ${kdeconnect-pointer}"
        "noborder, ${kdeconnect-pointer}"
        "suppressevent fullscreen, ${kdeconnect-pointer}"
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
        active_opacity = 0.85;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.00;
        rounding = 7;
        blur = {
          enabled = true;
          size = 3;
          passes = 4;
          new_optimizations = true;
          ignore_opacity = true;
          popups = true;
        };
        drop_shadow = false;
        shadow_range = 3;
        shadow_offset = "3 3";
        "col.shadow" = "0x44000000";
        "col.shadow_inactive" = "0x66000000";
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.1, 0, 0.5, 0"
          "easeinback,0.35, 0, 0.95, -0.3"
          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.35, 1.35, 0.65, 1"
          "easeinout,0.45, 0, 0.55, 1"
        ];

        animation = [
          "fadeIn,1,3,easeout"
          "fadeLayersIn,1,3,easeoutback"
          "layersIn,1,3,easeoutback,slide"
          "windowsIn,1,3,easeoutback,slide"
          "fadeLayersOut,1,3,easeinback"
          "fadeOut,1,3,easein"
          "layersOut,1,3,easeinback,slide"
          "windowsOut,1,3,easeinback,slide"
          "border,1,3,easeout"
          "fadeDim,1,3,easeinout"
          "fadeShadow,1,3,easeinout"
          "fadeSwitch,1,3,easeinout"
          "windowsMove,1,3,easeoutback"
          "workspaces,1,2.6,easeoutback,slide"
        ];
      };

      exec = [
        "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
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
          },${toString m.x}x${toString m.y},1"
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
    '';
  };
}
