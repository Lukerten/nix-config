{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.filezilla;
in {
  options.programs.filezilla = {
    enable = mkEnableOption "filezilla";

    package = mkOption {
      type = types.package;
      default = pkgs.filezilla;
      description = "The Filezilla package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
