{
  pkgs,
  lib,
  config,
  ...
}: let
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
  monitor = lib.head (lib.filter (m: m.primary) config.monitors);
  steam-session = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--prefer-output ${monitor.name}"
      "--adaptive-sync"
      "--expose-wayland"
      "--hdr-enabled"
      "--steam"
    ];
    steam = lib.concatStringsSep " " [
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
    enable = lib.mkEnableOption "xivlauncher";
    package = lib.mkOption {
      type = lib.types.package;
      default = steam-with-pkgs;
      description = "The xivlauncher package to use.";
    };
    withSession = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable Steam Session.";
    };
    SessionPackage = lib.mkOption {
      type = lib.types.package;
      default = steam-session;
      description = "The SteamSession package to use.";
    };
    withGamescope = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable Gamescope.";
    };
    GamescopePackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gamescope;
      description = "The Gamescope package to use.";
    };
    withProtontricks = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable Protontricks.";
    };
    ProtontricksPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.protontricks;
      description = "The Protontricks package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [cfg.package]
      ++ lib.optionals cfg.withSession [cfg.SessionPackage]
      ++ lib.optionals cfg.withGamescope [cfg.GamescopePackage]
      ++ lib.optionals cfg.withProtontricks [cfg.ProtontricksPackage];
  };
}
