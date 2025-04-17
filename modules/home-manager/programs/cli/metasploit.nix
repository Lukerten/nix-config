{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.metasploit;
in {
  options.programs.metasploit = {
    enable = mkEnableOption "metasploit framework";

    package = mkOption {
      type = types.package;
      default = pkgs.metasploit;
      description = "The Metasploit Framework package.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
