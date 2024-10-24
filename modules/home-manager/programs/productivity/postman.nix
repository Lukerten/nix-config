{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.postman;
in {
  options.programs.postman = {
    enable = lib.mkEnableOption "postman";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.postman;
      description = "The Postman package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
