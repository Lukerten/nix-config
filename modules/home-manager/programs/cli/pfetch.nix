{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.pfetch;
in {
  options.programs.pfetch = {
    enable = lib.mkEnableOption "pfetch";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pfetch-rs;
      description = "The pfetch package";
    };

    config_string = lib.mkOption {
      type = with lib.types; nullOr str;
      default = "ascii title os kernel de shell editor palette";
      description = "The pfetch config string";
    };
  };
  config = lib.mkIf cfg.enable {
    home = {
      packages = [cfg.package];
      sessionVariables.PF_INFO = cfg.config_string;
    };
  };
}
