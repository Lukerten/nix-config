{ pkgs, lib, config, ... }:
let
  cfg = config.programs.rofi;
  rofi-menu = pkgs.writeShellScriptBin "rofi-menu" ''
    rofi \
      -show drun \
      -theme $HOME/.config/rofi/launcher.rasi
  '';
in {
  options.programs.rofi = {
    enableLauncher = lib.mkEnableOption "rofi-launcher";
    launcherScript = lib.mkOption {
      type = lib.types.package;
      default = rofi-menu;
    };
  };

  config = lib.mkIf cfg.enableLauncher {
    home.packages = [ cfg.launcherScript ];
    xdg.configFile."rofi/launcher.rasi".source = ./launcher.rasi;
  };
}
