{ config, lib,... }:
let
  inherit (config.colorscheme) colors harmonized;
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
  foreground = rgba colors.on_surface "ff";
  accent = rgba colors.primary "ff";
  background = rgba colors.surface "aa";
  red = rgba harmonized.red "ff";
  yellow = rgba harmonized.yellow "ff";
  primaryMonitor = lib.lists.last (builtins.filter (m: m.primary) config.monitors);
  primaryMonitorName = primaryMonitor.name;
  imageStr = toString config.wallpaper;
  font = config.fontProfiles.regular.name;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 3;
        hide_cursor = true;
        no_fade_in = false;
        disable_loading_bar = false;
      };
      background = {
        monitor = "";
        path = imageStr;
        blur_passes = 2;
        contrast = 0.9;
        brightness = 0.7;
        vibrancy = 0.18;
        vibrancy_darkness = 0.0;
      };

      label = [ 
        {
          monitor = primaryMonitorName;
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = foreground;
          font_size = 80;
          font_family = "steelfish outline regular";
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        {
          monitor = primaryMonitorName;
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = foreground;
          font_size = 28;
          font_family = font + " Bold";
          position = "0, 290";
          halign = "center";
          valign = "center";
        }
        {
          monitor = primaryMonitorName;
          text = "  $USER";
          color = foreground;
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = 18;
          font_family = font + " Bold";
          position = "0, -190";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [{
        monitor = primaryMonitorName;
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(255,255,255,0)";
        inner_color = background;
        font_color = accent;
        fail_color = red;
        check_color = yellow;
        fade_on_empty = false;
        font_family = font + "Bold";
        placeholder_text = "Enter Password";
        hide_input = false;
        position = "0, -250";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
