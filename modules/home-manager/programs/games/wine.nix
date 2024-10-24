{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.wine;
in {
  options.programs.wine = {
    enable = lib.mkEnableOption "wine";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nix-gaming.wine-ge;
      description = "The wine package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
