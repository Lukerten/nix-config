{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.whatsapp;
in {
  options.programs.whatsapp = {
    enable = mkEnableOption "Enable WhatsApp messager";
    package = mkOption {
      type = types.package;
      default = pkgs.whatsapp-for-linux;
      description = "WhatsApp messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
