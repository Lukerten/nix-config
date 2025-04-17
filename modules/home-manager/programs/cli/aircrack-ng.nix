{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.aircrack-ng;
in {
  options.programs.aircrack-ng = {
    enable = mkEnableOption "aircrack-ng wireless security tools";
    package = mkOption {
      type = types.package;
      default = pkgs.aircrack-ng;
      description = "Aircrack-ng package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
