{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.office;
in {
  options.programs.office = {
    enable = mkEnableOption "office";

    package = mkOption {
      type = types.package;
      default = pkgs.onlyoffice-bin;
      description = "The Office package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
