{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hyprpicker;
in {
  options.programs.hyprpicker = {
    enable = mkEnableOption "hyprpicker";

    package = mkOption {
      type = types.package;
      default = pkgs.hyprpicker;
      description = "The hyprpicker package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
