{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.audacity;
in {
  options.programs.audacity = {
    enable = lib.mkEnableOption "audacity";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.audacity;
      description = "The Audacity package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
