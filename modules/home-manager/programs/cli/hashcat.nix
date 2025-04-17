{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.hashcat;
in {
  options.programs.hashcat = {
    enable = mkEnableOption "hashcat password cracking tool";
    package = mkOption {
      type = types.package;
      default = pkgs.hashcat;
      description = "The package to use for hashcat.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
