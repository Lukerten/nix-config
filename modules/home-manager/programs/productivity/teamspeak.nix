{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.teamspeak;
in {
  options.programs.teamspeak = {enable = lib.mkEnableOption "teamspeak";};
  config = lib.mkIf cfg.enable {home.packages = [pkgs.teamspeak_client];};
}
