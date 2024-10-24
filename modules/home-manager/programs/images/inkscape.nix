{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.inkscape;
  defaultPackage = pkgs.inkscape;
in {
  options.programs.inkscape = {
    enable = lib.mkEnableOption "inkscape";

    package = lib.mkOption {
      type = lib.types.package;
      default = defaultPackage;
      description = "The inkscape package to use.";
    };
  };

  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
