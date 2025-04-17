{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.signal;
in {
  options.programs.signal = {
    enable = mkEnableOption {
      type = types.bool;
      default = false;
      description = "Enable the Signal messager";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.signal-desktop;
      description = "Signal messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
