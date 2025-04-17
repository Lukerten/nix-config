{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.suits.dev.appdev;
in {
  options.suits.dev.appdev = {
    enable = mkEnableOption "App development";
  };

  config.programs = mkIf cfg.enable {
    androidStudio.enable = mkDefault true;
  };
}
