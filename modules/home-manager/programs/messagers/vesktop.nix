{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (config.colorschemes) colors harmonized;
  cfg = config.programs.vesktop; 
in {
  options.programs.vesktop = {
    enable = mkEnableOption "discord";
    package = mkOption {
      type = types.package;
      default = pkgs.stable.vesktop;
      description = "The code package to use.";
    };
    customCss = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable custom CSS";
      };
      text = mkOption {
        type = types.str;
        default = "";
        description = "Custom CSS to use";
      };
      file = mkOption {
        type = types.str;
        default = "custom";
        description = "Name of the custom CSS file (without extension)";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."vesktop/themes/${cfg.customCss.file}.css".text = mkIf cfg.customCss.enable cfg.customCss.text;
  };
}
