{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.rofi;
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
        selection=$(cliphist list | rofi -dmenu -i -p "󰅇")

        if [ -n "$selection" ]; then
          entry_id=$(echo "$selection" | awk '{print $1}')
          cliphist decode "$entry_id" | wl-copy
        fi
      '';
      description = "Package for clipboard history for rofi";
    };
  };

  config = mkIf cfg.cliphist.enable {
    home.packages = [cfg.cliphist.package];
  };
}
