{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.steam;
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver

        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
      ];
  };
  monitor = head (filter (m: m.primary) config.monitors);
  steam-session = let
    gamescope = concatStringsSep " " [
      (getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--prefer-output ${monitor.name}"
      "--adaptive-sync"
      "--expose-wayland"
      "--hdr-enabled"
      "--steam"
    ];
    steam = concatStringsSep " " [
      "steam"
      "steam://open/bigpicture"
    ];
  in
    pkgs.writeTextDir "share/wayland-sessions/steam-session.desktop" # ini

    ''
      [Desktop Entry]
      Name=Steam Session
      Exec=${gamescope} -- ${steam}
      Type=Application
    '';
in {
  options.programs.steam = {
    enable = mkEnableOption "xivlauncher";
    package = mkOption {
      type = types.package;
      default = steam-with-pkgs;
      description = "The xivlauncher package to use.";
    };
    withSession = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Steam Session.";
    };
    SessionPackage = mkOption {
      type = types.package;
      default = steam-session;
      description = "The SteamSession package to use.";
    };
    withGamescope = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Gamescope.";
    };
    GamescopePackage = mkOption {
      type = types.package;
      default = pkgs.gamescope;
      description = "The Gamescope package to use.";
    };
    withProtontricks = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Protontricks.";
    };
    ProtontricksPackage = mkOption {
      type = types.package;
      default = pkgs.protontricks;
      description = "The Protontricks package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      [cfg.package]
      ++ optionals cfg.withSession [cfg.SessionPackage]
      ++ optionals cfg.withGamescope [cfg.GamescopePackage]
      ++ optionals cfg.withProtontricks [cfg.ProtontricksPackage];
  };
}
