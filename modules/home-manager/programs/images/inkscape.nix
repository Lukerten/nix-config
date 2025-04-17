{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.inkscape;
  defaultPackage = pkgs.inkscape;
in {
  options.programs.inkscape = {
    enable = mkEnableOption "inkscape";

    package = mkOption {
      type = types.package;
      default = defaultPackage;
      description = "The inkscape package to use.";
    };
  };

  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
