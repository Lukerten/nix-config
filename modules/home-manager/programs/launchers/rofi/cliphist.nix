{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.rofi;
  inherit (lib) mkIf mkOption types;
in {
  options.programs.rofi.cliphist = {
    enable = mkOption {
      type = types.bool;
      default = config.services.cliphist.enable && cfg.enable;
      description = "Enable clipboard history for rofi";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.writeShellScriptBin "rofi-cliphist" ''
        selected=$(cliphist list | rofi -dmenu) && printf "$selected" | cliphist decode | wl-copy
      '';
      description = "Package for clipboard history for rofi";
    };
  };

  config = mkIf cfg.cliphist.enable {
    home.packages = [cfg.cliphist.package];
  };
}
