{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.audacity;
in {
  options.programs.audacity = {
    enable = mkEnableOption "audacity";

    package = mkOption {
      type = types.package;
      default = pkgs.audacity;
      description = "The Audacity package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
