{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.obsidian;
in {
  options.programs.obsidian = {
    enable = mkEnableOption "obsidian";

    package = mkOption {
      type = types.package;
      default = pkgs.obsidian;
      description = "The obsidian package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
