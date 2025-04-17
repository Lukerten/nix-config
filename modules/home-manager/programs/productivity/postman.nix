{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.postman;
in {
  options.programs.postman = {
    enable = mkEnableOption "postman";

    package = mkOption {
      type = types.package;
      default = pkgs.postman;
      description = "The Postman package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
