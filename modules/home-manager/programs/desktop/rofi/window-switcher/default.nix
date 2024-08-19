{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.rofi;
  rofi-window = pkgs.writeShellScriptBin "rofi-window" ''
    rofi \
      -show window\
      -theme $HOME/.config/rofi/window_switcher.rasi
  '';
in {
  options.programs.rofi = {
    enableWindow = lib.mkEnableOption "rofi-window";
    windowScript = lib.mkOption {
      type = lib.types.package;
      default = rofi-window;
    };
  };

  config = lib.mkIf cfg.enableWindow {
    home.packages = [cfg.launcherScript];
    xdg.configFile."rofi/window_switcher.rasi".source = ./theme.rasi;
  };
}
