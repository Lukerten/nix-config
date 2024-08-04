{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.code;
in {
  options.programs.code = {
    enable = lib.mkEnableOption "code";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.vscode;
      description = "The code package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
