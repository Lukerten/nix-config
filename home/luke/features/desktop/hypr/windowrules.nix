{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = let
      sweethome3d-tooltips = "title:win[0-9],class:com-eteks-sweethome3d-SweetHome3DBootstrap";
      steamGame = "class:steam_app_[0-9]*";
      kdeconnect-pointer = "class:org.kdeconnect.daemon";
      wineTray = "class:explorer.exe";
      rsiLauncher = "class:rsi launcher.exe";
      steamBigPicture = "title:Steam Big Picture Mode";
    in [
      "nofocus, ${sweethome3d-tooltips}"

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

      "workspace special silent, ${wineTray}"

      "tile, ${rsiLauncher}"

      "fullscreen, ${steamBigPicture}"
    ];
  };
}
