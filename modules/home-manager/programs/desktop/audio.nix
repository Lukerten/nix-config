{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.audioctrl;
in {
  options.programs.audioctrl = {enable = lib.mkEnableOption "audio";};
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.pavucontrol pkgs.playerctl];
  };
}
