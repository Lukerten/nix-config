{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.webex;
in {
  options.programs.webex = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Webex";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.webex;
      description = "Webex messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
