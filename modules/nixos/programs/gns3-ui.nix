{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.gns3-ui;
in {
  options.programs.gns3-ui = {
    enable = lib.mkEnableOption "gns3UI";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gns3-gui;
      description = "The gns3UI package to use.";
    };
  };
  config = lib.mkIf cfg.enable {environment.systemPackages = [cfg.package];};
}
