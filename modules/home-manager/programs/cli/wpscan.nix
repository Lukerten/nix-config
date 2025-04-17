{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.wpscan;
in {
  options.programs.wpscan = {
    enable = mkEnableOption "wpscan wordpress security scanner";

    package = mkOption {
      type = types.package;
      default = pkgs.wpscan;
      description = "The wpscan package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
