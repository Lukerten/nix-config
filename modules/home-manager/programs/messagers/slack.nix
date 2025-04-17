{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.slack;
in {
  options.programs.slack = {
    enable = mkEnableOption {
      type = types.bool;
      default = false;
      description = "Enable Slack";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.slack;
      description = "Slack messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
