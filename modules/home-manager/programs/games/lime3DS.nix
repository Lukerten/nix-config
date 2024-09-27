{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.lime3DS;
in {
  options.programs.lime3DS = {
    enable = lib.mkEnableOption "lime3DS";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.lime3ds;
      description = "The lime3DS package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
