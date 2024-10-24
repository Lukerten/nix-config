{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.krita;
in {
  options.programs.krita = {
    enable = lib.mkEnableOption "krita";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.krita;
      description = "The krita package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
