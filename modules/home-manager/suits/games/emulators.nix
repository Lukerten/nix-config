{
  config,
  lib,
  ...
}: let
  cfg = config.suits.games.emulators;
in {
  options.suits.games.emulators = {
    enable = lib.mkEnableOption "emulators";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      dolphin.enable = lib.mkDefault true;
      melonDS.enable = lib.mkDefault true;
      mGBA.enable = lib.mkDefault true;
    };
  };
}
