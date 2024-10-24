{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.rofi;
  rofi-specialisation = pkgs.writeShellScriptBin "rofi-specialisation" ''
    specialisation $(specialisation | rofi -dmenu -theme $HOME/.config/rofi/specialisation.rasi)
  '';
in {
  options.programs.rofi = {
    enableSpecialisation = lib.mkEnableOption "rofi-specialisation";
    specialisationScript = lib.mkOption {
      type = lib.types.package;
      default = rofi-specialisation;
    };
  };

  config = lib.mkIf cfg.enableLauncher {
    home.packages = [cfg.specialisationScript];
    xdg.configFile."rofi/specialisation.rasi".source = ./theme.rasi;
  };
}
