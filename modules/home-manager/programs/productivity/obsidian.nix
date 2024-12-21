{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
  cfg = config.programs.obsidian;
in {
  options.programs.obsidian = {
    enable = lib.mkEnableOption "obsidian";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.obsidian;
      description = "The obsidian package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
