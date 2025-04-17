{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.teams;
in {
  options.programs.teams = {
    enable = mkEnableOption {
      type = types.bool;
      default = false;
      description = "Enable Teams";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.teams;
      description = "MS Teams package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
