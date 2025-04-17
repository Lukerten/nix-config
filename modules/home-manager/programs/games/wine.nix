{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.wine;
in {
  options.programs.wine = {
    enable = mkEnableOption "wine";

    package = mkOption {
      type = types.package;
      default = pkgs.nix-gaming.wine-ge;
      description = "The wine package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
