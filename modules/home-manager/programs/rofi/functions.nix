{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.rofi;
  inherit (lib) mkIf mkOption mkEnableOption types;
in {
  options.programs.rofi = {
    launcher = let
      rofi-theme = ./launcher.rasi;
      rofi-script = pkgs.writeShellScriptBin "rofi-menu" ''
        rofi \
          -show drun \
          -theme $HOME/.config/rofi/launcher.rasi
      '';
    in {
      enable = mkEnableOption "rofi-launcher";
      theme = mkOption {
        type = types.path;
        default = rofi-theme;
        description = "Path to the rofi config";
      };
      package = mkOption {
        type = types.package;
        default = rofi-script;
        description = "Path to the rofi script";
      };
    };

    # Window switcher
    windowSwitcher = let
      rofi-theme = ./window.rasi;
      rofi-script = pkgs.writeShellScriptBin "rofi-window" ''
        rofi \
          -show window\
          -theme $HOME/.config/rofi/window.rasi
      '';
    in {
      enable = mkEnableOption "rofi-window";
      theme = mkOption {
        type = types.path;
        default = rofi-theme;
        description = "Path to the rofi config";
      };
      package = mkOption {
        type = types.package;
        default = rofi-script;
        description = "Path to the rofi script";
      };
    };

    # Clipboard
    cliphist = let
      hasCliphist = config.services.cliphist.enable;
      rofi-theme = ./default.rasi;
      rofi-script = pkgs.writeShellScriptBin "rofi-clipper" ''
        selected=$(cliphist list | rofi -dmenu) && printf "$selected" | cliphist decode | wl-copy
      '';
    in {
      enable = mkOption {
        type = types.bool;
        default = hasCliphist;
        description = "Enable clipboard history for rofi";
      };
      theme = mkOption {
        type = types.path;
        default = rofi-theme;
        description = "Path to the rofi config";
      };
      package = mkOption {
        type = types.package;
        default = rofi-script;
        description = "Package for clipboard history for rofi";
      };
    };

    specialisation = let
      packageNames = map (p: p.pname or p.name or null) config.home.packages;
      hasPackage = name: lib.any (x: x == name) packageNames;
      hasSpecialisationCli = hasPackage "specialisation";
      rofi-theme = ./default.rasi;
      rofi-script = pkgs.writeShellScriptBin "rofi-specialisation" ''
        specialisation $(specialisation | rofi -dmenu -theme $HOME/.config/rofi/specialisation.rasi)
      '';
    in {
      enable = mkOption {
        type = types.bool;
        default = hasSpecialisationCli;
        description = "Enable specialisation for rofi";
      };
      theme = mkOption {
        type = types.path;
        default = rofi-theme;
        description = "Path to the rofi config";
      };
      package = mkOption {
        type = types.package;
        default = rofi-script;
        description = "Package for specialisation for rofi";
      };
    };
  };

  config = {
    xdg.configFile = {
      "rofi/launcher.rasi".source = mkIf cfg.launcher.enable cfg.launcher.theme;
      "rofi/cliphist.rasi".source = mkIf cfg.cliphist.enable cfg.cliphist.theme;
      "rofi/specialisation.rasi".source = mkIf cfg.specialisation.enable cfg.specialisation.theme;
    };
  };
}
