{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.melonDS;
in {
  options.programs.melonDS = {
    enable = lib.mkEnableOption "melonDS";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.melonDS;
      description = "The melonDS package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
