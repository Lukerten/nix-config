{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  homeCfgs = config.home-manager.users;
  lukeCfg = homeCfgs.luke;
  hasThunar = mkIf lukeCfg.programs.thunar.enable true;
in {
  # TODO: move this into home-manager
  programs.xfconf.enable = hasThunar;
  services.gvfs.enable = hasThunar;
  services.tumbler.enable = hasThunar;
}
