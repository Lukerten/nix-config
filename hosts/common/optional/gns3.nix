{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.gns3-ui.enable = true;
  environment.systemPackages = [ pkgs.gns3-server ];
}
