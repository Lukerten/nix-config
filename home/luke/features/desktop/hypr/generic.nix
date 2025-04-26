{
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = let
      rgb = color: "rgb(${lib.removePrefix "#" color})";
      rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
      c = config.colorscheme.colors;
    in {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = true;
        "col.active_border" = "${rgb c.secondary} ${rgb c.primary} ${rgb c.tertiary} 45deg";
        "col.inactive_border" = "${rgb c.surface}";
      };
      cursor.inactive_timeout = 4;
      group = {
        "col.border_active" = rgb config.colorscheme.colors.primary;
        "col.border_inactive" = rgb config.colorscheme.colors.surface;
        "col.border_locked_active" = rgb config.colorscheme.colors.primary;
        "col.border_locked_inactive" = rgb config.colorscheme.colors.surface;
        groupbar = {
          height = 16;
          font_size = 12;
          gradients = true;
          text_color = rgb config.colorscheme.colors.on_surface;
          "col.active" = rgba config.colorscheme.colors.primary "cc";
          "col.inactive" = rgba config.colorscheme.colors.surface "cc";
          "col.locked_active" = rgba config.colorscheme.colors.on_surface "cc";
          "col.locked_inactive" = rgba config.colorscheme.colors.surface "cc";
        };
      };
      binds = {
        movefocus_cycles_fullscreen = false;
      };
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
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
        []
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
  };
}
