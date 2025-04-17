{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.nmap;
in {
  options.programs.nmap = {
    enable = mkEnableOption "nmap network scanner";

    package = mkOption {
      type = types.package;
      default = pkgs.nmap;
      description = "The nmap package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
