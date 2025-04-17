{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.deluge;
in {
  options.programs.deluge = {enable = mkEnableOption "deluge";};
  config = mkIf cfg.enable {home.packages = [pkgs.deluge];};
}
