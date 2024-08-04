{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.dragon;
in {
  options.programs.dragon = {
    enable = lib.mkEnableOption "dragon";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xdragon;
      description = "The dragon package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
