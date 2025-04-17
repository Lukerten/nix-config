{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hyprshot;
in {
  options.programs.hyprshot = {
    enable = mkEnableOption "hyprshot";

    package = mkOption {
      type = types.package;
      default = pkgs.hyprshot;
      description = "The hyprshot package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
