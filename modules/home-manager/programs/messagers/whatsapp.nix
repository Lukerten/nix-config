{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.whatsapp;
in {
  options.programs.whatsapp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable WhatsApp messager";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.whatsapp-for-linux;
      description = "WhatsApp messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
