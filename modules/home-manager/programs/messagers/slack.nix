{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.slack;
in { 
  options.programs.slack = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Slack";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.slack;
      description = "Slack messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
