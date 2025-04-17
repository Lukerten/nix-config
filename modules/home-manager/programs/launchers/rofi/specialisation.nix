{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.rofi;
in {
  options.programs.rofi.specialisation = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable specialisation for rofi";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.writeShellScriptBin "rofi-specialisation" ''
        specialisation $(specialisation | rofi -dmenu)
      '';
      description = "Package for specialisation for rofi";
    };
  };

  config = mkIf cfg.specialisation.enable {
    home.packages = [cfg.specialisation.package];
  };
}
