{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.webex;
in {
  options.programs.webex = {
    enable = mkEnableOption "Enable Webex";
    package = mkOption {
      type = types.package;
      default = pkgs.webex;
      description = "Webex messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
