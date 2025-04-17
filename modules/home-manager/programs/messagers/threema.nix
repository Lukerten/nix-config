{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.threema;
in {
  options.programs.threema = {
    enable = mkEnableOption "Enable Threema";
    package = mkOption {
      type = types.package;
      default = pkgs.threema-desktop;
      description = "Threema messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
