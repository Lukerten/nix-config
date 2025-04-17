{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.resolve;
in {
  options.programs.resolve = {
    enable = mkEnableOption "Davinci Resolve";

    package = mkOption {
      type = types.package;
      default = pkgs.davinci-resolve;
      description = "The Davinci Resolve package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
