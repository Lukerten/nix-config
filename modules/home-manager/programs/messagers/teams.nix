{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.teams;
in {
  options.programs.teams = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Teams";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.teams;
      description = "MS Teams package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
