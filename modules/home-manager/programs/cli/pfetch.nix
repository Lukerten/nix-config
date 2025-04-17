{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.pfetch;
in {
  options.programs.pfetch = {
    enable = mkEnableOption "pfetch";

    package = mkOption {
      type = types.package;
      default = pkgs.pfetch-rs;
      description = "The pfetch package";
    };

    config_string = mkOption {
      type = with types; nullOr str;
      default = "ascii title os kernel de shell editor palette";
      description = "The pfetch config string";
    };
  };
  config = mkIf cfg.enable {
    home = {
      packages = [cfg.package];
      sessionVariables.PF_INFO = cfg.config_string;
    };
  };
}
