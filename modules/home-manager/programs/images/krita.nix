{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.krita;
in {
  options.programs.krita = {
    enable = mkEnableOption "krita";

    package = mkOption {
      type = with pkgs; types.package;
      default = pkgs.krita;
      description = "The krita package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
