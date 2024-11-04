{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.hyprpicker;
in {
  options.programs.hyprpicker = {
    enable = lib.mkEnableOption "hyprpicker";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hyprpicker;
      description = "The hyprpicker package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
