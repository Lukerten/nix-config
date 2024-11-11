{
  outputs,
  config,
  lib,
  pkgs,
  inputs,
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

  swayCfg = config.wayland.windowManager.sway;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in {
  systemd.user.services.waybar = {Unit.StartLimitBurst = 30;};
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });

    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";

        modules-left =
          ["custom/menu"]
          ++ (lib.optionals swayCfg.enable ["sway/workspaces" "sway/mode"])
          ++ (lib.optionals hyprlandCfg.enable [
            "hyprland/workspaces"
            "hyprland/submap"
          ])
          ++ ["custom/currentplayer" "custom/player"];

        modules-center = [
        ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "clock"
        ];

        # Modules
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          format-alt = "{:%d.%m.%y %H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = {format = "  {usage}%";};
        "custom/gpu" = {
          interval = 5;
          exec = mkScript {
            script = "cat /sys/class/drm/card1/device/gpu_busy_percent";
          };
          format = "󰒋  {}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };
        pulseaudio = {
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 0%";
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰸈 0% {format_source}";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          on-click = lib.getExe pkgs.pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon} ";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        battery = {
          bat = "BAT1";
          interval = 10;
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        "sway/window" = {max-length = 20;};
        network = {
          interval = 3;
          format-wifi = " ";
          format-ethernet = "󰈁";
          format-disconnected = "󱘖";
          tooltip-format = ''
            {ifname} {essid}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        "custom/menu" = {
          interval = 1;
          return-type = "json";
          on-click = lib.mkIf config.programs.rofi.launcher.enable "${lib.getExe config.programs.rofi.launcher.script}";
          exec = mkScriptJson {
            deps = lib.optional hyprlandCfg.enable hyprlandCfg.package;
            text = "";
            tooltip = ''$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)'';
            class = let
              isFullScreen =
                if hyprlandCfg.enable
                then "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null"
                else "false";
            in "$(if ${isFullScreen}; then echo fullscreen; fi)";
          };
        };
        "custom/hostname" = {
          exec = mkScript {script = ''echo "$USER@$HOSTNAME"'';};
          on-click = mkScript {script = "systemctl --user restart waybar";};
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
        "hyprland/workspaces" = {
          on-click = "activate";
          sort-by-number = true;
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      inherit (config.colorscheme) colors;
      toRGBA = color: opacity: "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
      # css
    in ''
      * {
        font-family: ${config.fontProfiles.regular.name}, ${config.fontProfiles.monospace.name};
        font-size: 12pt;
        padding: 0;
        margin: 0 0.4em;
      }
      window#waybar {
        padding: 0;
        border-radius: 0.5em;
        background-color: ${toRGBA colors.surface "0.7"};
        color: ${colors.on_surface};
      }
      tooltip {
        color: ${colors.on_surface};
        background-color: ${toRGBA colors.surface "0.9"};
        text-shadow: none;
      }
      .modules-left {
        margin-left: -0.65em;
      }
      .modules-right {
        margin-right: -0.65em;
      }

      #workspaces button {
        background-color: transparent;
        color: ${colors.on_surface};
        padding-left: 0.2em;
        padding-right: 0.2em;
        margin: 0.15em 0;
        transition: background-color 0.2s;
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: ${colors.primary};
        color: ${colors.on_primary};
      }

      #custom-menu {
        background-color: ${colors.surface};
        color: ${colors.primary};
        padding-right: 1.5em;
        padding-left: 1em;
        margin-right: 0;
        border-radius: 0.5em;
      }

      #clock {
        font-family: ${config.fontProfiles.monospace.name};
        background-color: ${colors.surface};
        color: ${colors.primary};
        padding-right: 1em;
        padding-left: 1em;
        margin-left: 0;
        border-radius: 0.5em;
      }
      #custom-currentplayer {
        padding-right: 0;
      }
      #tray {
        color: ${colors.on_surface};
      }
      #custom-gpu, #cpu, #memory {
        margin-left: 0.05em;
        margin-right: 0.55em;
      }
    '';
  };
}
