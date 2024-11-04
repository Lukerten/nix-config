{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.hyprshot;
in {
  options.programs.hyprshot = {
    enable = lib.mkEnableOption "hyprshot";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hyprshot;
      description = "The hyprshot package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
