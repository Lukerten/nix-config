{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.gimp;
in {
  options.programs.gimp = {
    enable = mkEnableOption "gimp";

    package = mkOption {
      type = types.package;
      default = pkgs.gimp;
      description = "The Gimp package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
