{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.resolve;
in {
  options.programs.resolve = {
    enable = lib.mkEnableOption "Davinci Resolve";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.davinci-resolve;
      description = "The Davinci Resolve package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
