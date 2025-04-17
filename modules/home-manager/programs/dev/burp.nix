{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.burpsuite;
in {
  options.programs.burpsuite = {
    enable = mkEnableOption "burpsuite web security testing tool";

    package = mkOption {
      type = types.package;
      default = pkgs.burpsuite;
      description = "Burp Suite package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
