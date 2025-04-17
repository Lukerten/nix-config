{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.xpo;
  package = pkgs.xpo;
in {
  options.programs.xpo = {
    enable = mkEnableOption "xpo";

    defaultServer = mkOption {
      default = null;
      type = with types; nullOr str;
      description = ''
        Default SSH server/endpoint to use when tunneling.
      '';
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [package];
      sessionVariables.XPO_SERVER =
        optionalString (cfg.defaultServer != null) cfg.defaultServer;
    };
  };
}
