{
  config,
  lib,
  pkgs,
  ...
}: let
  commonDeps = with pkgs; [coreutils gnugrep systemd];
  mkScript = {
    name ? "script",
    deps ? [],
    script ? "",
  }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });

  mkScriptJson = {
    name ? "script",
    deps ? [],
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }:
    mkScript {
      inherit name;
      deps = [pkgs.jq] ++ deps;
      script = ''
        ${pre}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };
in {
  programs.waybar.settings.primary = {
    "hyprland/workspaces" = {
      on-scroll-up = "hyprctl dispatch workspace r-1";
      on-scroll-down = "hyprctl dispatch workspace r+1";
      on-click = "activate";
      active-only = false;
      all-outputs = true;
      sort-by-number = true;
    };

    "wlr/taskbar" = {
      format = "{icon}";
      all-outputs = false;
      on-click = "activate";
      on-click-middle = "close";
      rewrite = {
        "Firefox Web Browser" = "Firefox";
        "Alacritty" = "Terminal";
        "Kitty" = "Terminal";
        "Foot" = "Terminal";
        "~" = "Terminal";
      };
    };

    "hyprland/window" = {
      separate-outputs = true;
    };

    "custom/menu" = {
      format = "";
      on-click = lib.mkMerge [
        "sleep 0.2;pkill rofi || ${lib.getExe config.programs.rofi.package} -show drun -replace"
      ];
      tooltip-format = "Open the application Launcher";
    };

    "custom/currentplayer" = {
      interval = 2;
      return-type = "json";
      exec = mkScriptJson {
        deps = [pkgs.playerctl];
        pre = ''
          player="$(playerctl status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
          count="$(playerctl -l 2>/dev/null | wc -l)"
          if ((count > 1)); then
            more=" +$((count - 1))"
          else
            more=""
          fi
        '';
        alt = "$player";
        tooltip = "$player ($count available)";
        text = "$more";
      };
      format = "{icon}{}";
      format-icons = {
        "No player active" = " ";
        "Celluloid" = "󰎁 ";
        "spotify" = "󰓇 ";
        "ncspot" = "󰓇 ";
        "qutebrowser" = "󰖟 ";
        "firefox" = " ";
        "discord" = " 󰙯 ";
        "sublimemusic" = " ";
        "kdeconnect" = "󰄡 ";
        "chromium" = " ";
      };
    };

    "custom/player" = {
      exec-if = mkScript {
        deps = [pkgs.playerctl];
        script = "playerctl status 2>/dev/null";
      };
      exec = let
        format = ''
          {"text": "{{title}} - {{artist}}", "alt": "{{status}}", "tooltip": "{{title}} - {{artist}} ({{album}})"}'';
      in
        mkScript {
          deps = [pkgs.playerctl];
          script = "playerctl metadata --format '${format}' 2>/dev/null";
        };
      return-type = "json";
      interval = 2;
      max-length = 30;
      format = "{icon} {}";
      format-icons = {
        "Playing" = "󰐊";
        "Paused" = "󰏤 ";
        "Stopped" = "󰓛";
      };
      on-click = mkScript {
        deps = [pkgs.playerctl];
        script = "playerctl play-pause";
      };
      on-click-right = mkScript {
        deps = [pkgs.playerctl];
        script = "playerctl next";
      };
      on-click-middle = mkScript {
        deps = [pkgs.playerctl];
        script = "playerctl shuffle";
      };
    };

    "custom/empty" = {
      format = "";
    };

    tray = {
      spacing = 10;
    };

    clock = {
      interval = 1;
      format = "{:%H:%M:%S}";
      format-alt = "{:%d.%m.%y %H:%M:%S}";
      on-click-left = "mode";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };

    pulseaudio = {
      format-source = "󰍬 {volume}%";
      format-source-muted = "󰍭 0%";
      format = "{icon} {volume}% {format_source}";
      format-muted = "󰸈 0% {format_source}";
      format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
      on-click = lib.getExe pkgs.pavucontrol;
    };

    bluetooth = {
      format = "󰂯 ";
      format-disabled = "󰂲 ";
      format-off = "󰂲 ";
      format-no-controller = "";
      interval = 30;
      on-click-left = lib.optionals config.programs.rofi.enable lib.getExe pkgs.rofi-bluetooth;
      on-click-middle = "bluetoothctl power off";
      on-click-right = "bluetoothctl power on";
    };

    network = {
      format = "{ifname}";
      format-wifi = "  ";
      format-ethernet = "󰈁 ";
      format-disconnected = "󱘖 ";
      tooltip-format = ''
        {ifname} via {gwaddri}
      '';
      tooltip-format-wifi = ''
        {ifname} @ {essid}
        IP:       {ipaddr}
        Strength: {signalStrength}%
        Freq:     {frequency}MHz
        Up: {bandwidthUpBits}
        Down: {bandwidthDownBits}
      '';
      tooltip-format-ethernet = ''
        {ifname}
        IP:       {ipaddr}
        Up:       {bandwidthUpBits}
        Down:     {bandwidthDownBits}
      '';
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
    };



    backlight = {
      format = "{icon} {percent}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
      "scroll-step" = 1;
    };


    battery = {
      bat = "BAT1";
      interval = 10;
      format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      format = "{icon}";
      format-charging = "󰂄 {capacity}%";
    };

    user = {
      format = "{user}";
      interval = 60;
      icon = false;
    };


    idle_inhibitor = {
      format = "{icon} ";
      format-icons = {
        activated = "󰒳";
        deactivated = "󰒲";
      };
    };
  };
}
