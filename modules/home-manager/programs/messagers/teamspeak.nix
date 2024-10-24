{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.teamspeak;
in {
  options.programs.teamspeak = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable teamspeak";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.teamspeak_client;
      description = "teamspeak package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
