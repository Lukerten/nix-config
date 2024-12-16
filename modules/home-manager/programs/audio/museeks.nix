{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.museeks;
in {
  options.programs.museeks = {
    enable = lib.mkEnableOption "Museeks";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.museeks;
      description = "The Museeks package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
