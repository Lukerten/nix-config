{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf mkDefault types;
  cfg = config.suits.dev.gamedev;
in {
  options.suits.dev.gamedev = {
    enable = mkEnableOption "Game development";
  };

  config.programs = mkIf cfg.enable {
    unity.enable = mkDefault true;
    godot.enable = mkDefault true;
    blender.enable = mkDefault true;
    vscode.enable = mkDefault true;
  };

  config.xdg.mimeApps.defaultApplications = {
    "text/x-csharp" = "code.desktop";
  };
}
