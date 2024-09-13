{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];

    bind = let
      workspaces = [
        "0"
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "F1"
        "F2"
        "F3"
        "F4"
        "F5"
        "F6"
        "F7"
        "F8"
        "F9"
        "F10"
        "F11"
        "F12"
      ];
      # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        h = left;
        l = right;
        k = up;
        j = down;
      };

      wlogout = lib.getExe pkgs.wlogout;
      grimblast = lib.getExe pkgs.grimblast;
      tesseract = lib.getExe pkgs.tesseract;
      pactl = lib.getExe' pkgs.pulseaudio "pactl";
      notify-send = lib.getExe' pkgs.libnotify "notify-send";
      defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
    in
      [
        "SUPERSHIFT,q,killactive"
        "SUPERSHIFT,e,exec,${wlogout}"

        # Splitting and fullscreen
        "SUPER,t,togglesplit"
        "SUPER,f,fullscreen,1"
        "SUPERSHIFT,f,fullscreen,0"
        "SUPERSHIFT,space,togglefloating"
        "SUPER,minus,splitratio,-0.25"
        "SUPERSHIFT,minus,splitratio,-0.3333333"
        "SUPER,plus,splitratio,0.25"
        "SUPERSHIFT,plus,splitratio,0.3333333"

        # Focus and layout
        "SUPER,g,togglegroup"
        "SUPER,t,lockactivegroup,toggle"
        "SUPER,tab,changegroupactive,f"
        "SUPERSHIFT,tab,changegroupactive,b"
        "SUPER,w,workspace,previous"
        "SUPERSHIFT,w,workspace,next"

        # Special workspace
        "SUPER,u,togglespecialworkspace"
        "SUPERSHIFT,u,movetoworkspacesilent,special"
        "SUPER,i,pseudo"

        # Default applications
        "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
        "SUPER,e,exec,${defaultApp "text/plain"}"
        "SUPER,a,exec,${defaultApp "x-scheme-handler/https"}"
        "SUPER,r,exec,${defaultApp "inode/directory"}"

        # Brightness control (only works if the system has lightd)
        ",XF86MonBrightnessUp,exec,light -A 10"
        ",XF86MonBrightnessDown,exec,light -U 10"

        # Volume
        ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
        "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
        ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"

        # Screenshotting
        ",Print,exec,${grimblast} --notify --freeze copysave output"
        "SUPER,Print,exec,${grimblast} --notify --freeze copysave area"
        "ALT,Print,exec,${grimblast} --freeze save area - | ${tesseract} - - | wl-copy && ${notify-send} -t 3000 'OCR result copied to buffer'"
      ]
      ++
      # Change workspace
      (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
      ++
      # Swap windows
      (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},swapwindow,${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (
          key: direction: "SUPERCONTROL,${key},movewindoworgroup,${direction}"
        )
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "SUPERALT,${key},focusmonitor,${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (
          key: direction: "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        )
        directions)
      ++
      # Screen lock
      (let
        swaylock = lib.getExe config.programs.swaylock.package;
      in
        lib.optionals config.programs.swaylock.enable [
          "SUPER,backspace,exec,${swaylock} -S --grace 2 --grace-no-mouse"
          "SUPER,XF86Calculator,exec,${swaylock} -S --grace 2 --grace-no-mouse"
        ])
      ++
      # Notification manager
      (let
        makoctl = lib.getExe' config.services.mako.package "makoctl";
      in
        lib.optionals config.services.mako.enable [
          "SUPER,w,exec,${makoctl} dismiss"
          "SUPERSHIFT,w,exec,${makoctl} restore"
        ])
      ++
      # Launcher
      (let
        rofi-menu = lib.getExe config.programs.rofi.launcherScript;
      in
        lib.optionals config.programs.rofi.enableLauncher
        ["SUPER,d,exec,${rofi-menu}"])
      ++
      # Clipper
      (let
        rofi-clipper = lib.getExe config.programs.rofi.clipperScript;
      in
        lib.optionals config.programs.rofi.enableClipper
        ["SUPER,c,exec,${rofi-clipper}"])
      ++
      # Specialisation menu
      (let
        rofi-specialisation =
          lib.getExe config.programs.rofi.specialisationScript;
      in
        lib.optionals config.programs.rofi.enableSpecialisation
        ["SUPER,s,exec,${rofi-specialisation}"])
      ++
      # Window Switcher
      (let
        wofi-window-switcher =
          lib.getExe config.programs.rofi.windowScript;
      in
        lib.optionals config.programs.rofi.enableWindow
        ["SUPERCONTROL,Tab,exec,${wofi-window-switcher}"]);
  };
}
