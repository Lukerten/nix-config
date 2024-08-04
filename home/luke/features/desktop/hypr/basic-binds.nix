{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bindm = ["SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow"];

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
      directions = {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
      };
    in
      [
        "SUPERSHIFT,q,killactive"

        "SUPER, mouse_down, workspace, next"
        "SUPER, mouse_up, workspace, previous"
        "SUPER,t,togglesplit"
        "SUPER,f,fullscreen,1"
        "SUPERSHIFT,f,fullscreen,0"
        "SUPERSHIFT,space,togglefloating"

        "SUPER,minus,splitratio,-0.25"
        "SUPERSHIFT,minus,splitratio,-0.3333333"

        "SUPER,plus,splitratio,0.25"
        "SUPERSHIFT,plus,splitratio,0.3333333"

        "SUPER,g,togglegroup"
        "SUPER,t,lockactivegroup,toggle"
        "SUPER,tab,changegroupactive,f"
        "SUPERSHIFT,tab,changegroupactive,b"

        "SUPER,b,workspace,previous"
        "SUPERSHIFT,apostrophe,workspace,next"
        "SUPER,u,togglespecialworkspace"
        "SUPERSHIFT,u,movetoworkspacesilent,special"
        "SUPER,i,pseudo"
      ]
      ++
      # Change workspace
      (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}")
        directions)
      ++
      # Swap windows
      (lib.mapAttrsToList
        (key: direction: "SUPERSHIFT,${key},swapwindow,${direction}")
        directions)
      ++
      # Move windows
      (lib.mapAttrsToList
        (key: direction: "SUPERCONTROL,${key},movewindoworgroup,${direction}")
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList
        (key: direction: "SUPERALT,${key},focusmonitor,${direction}")
        directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (key: direction: "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}")
        directions);
  };
}
