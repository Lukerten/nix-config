{config, lib, ...}:let
  cfg = config.suits.emulators;
in {
  options.suits.emulators = {
    enable = lib.mkEnableOption "emulators";

    enableDolphin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Dolphin.";
    };

    enableMelonDS = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable MelonDS.";
    };
    enableLime3DS = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Lime3DS.";
    };
    enableMgba = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mGBA.";
    };
  };
  config = lib.mkIf cfg.enable {
    programs = {
      dolphin.enable = lib.mkDefault cfg.enableDolphin;
      melonDS.enable = lib.mkDefault cfg.enableMelonDS;
      lime3DS.enable = lib.mkDefault cfg.enableLime3DS;
      mGBA.enable = lib.mkDefault cfg.enableMgba;
    };
  };
}
