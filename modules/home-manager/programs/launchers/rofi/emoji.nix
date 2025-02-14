{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.rofi;
  inherit (lib) mkIf mkOption types;
in {
  options.programs.rofi.emoji = {
    enable = mkOption {
      type = types.bool;
      default = config.services.cliphist.enable && cfg.enable;
      description = "Enable clipboard history for rofi";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.rofimoji;
      description = "Package for clipboard history for rofi";
    };
  };

  config = mkIf cfg.emoji.enable {
    home.packages = [cfg.emoji.package];
    programs.rofi.plugins = [ cfg.emoji.package ];
  };
}
