{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.signal;
in {
  options.programs.signal = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Signal messager";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.signal-desktop;
      description = "Signal messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
