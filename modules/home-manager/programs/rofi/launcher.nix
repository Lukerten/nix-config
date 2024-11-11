{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.rofi.launcher;
in {
  options.programs.rofi.launcher = {
    enable = lib.mkEnableOption "rofi-launcher";

    configPath = lib.mkOption {
      type = lib.types.path;
      default = ./launcher.rasi;
      description = "Path to the rofi config";
    };

    script = lib.mkOption {
      type = lib.types.package;
      default = pkgs.writeShellScriptBin "rofi-menu" ''
        rofi \
          -show drun \
          -theme ${cfg.configPath}
      '';
      description = "Path to the rofi script";
    };
  };

  config = {
    xdg.configFile."rofi/launcher.rasi".source = cfg.configPath;
    home.packages  = lib.mkIf cfg.enable [
      cfg.script
    ];
  };
}
