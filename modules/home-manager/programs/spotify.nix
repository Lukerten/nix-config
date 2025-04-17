{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.spotify;
in {
  options.programs.spotify = {enable = mkEnableOption "spotify";};
  config = mkIf cfg.enable {home.packages = [pkgs.spotify];};
}
