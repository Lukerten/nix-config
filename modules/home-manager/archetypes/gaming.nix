{
  config,
  lib,
  ...
}: let
  cfg = config.archetypes.gaming;
in {
  options.archetypes.gaming = {
    enable = lib.mkEnableOption "Gaming";
    enableSteam = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam.";
    };
    enablePrismLauncher = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Prism Launcher.";
    };
    enableXIVLauncher = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable XIVLauncher.";
    };
    enableEmulators = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Emulators.";
    };
    enablePnP = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Pen and Paper.";
    };
  };
  config = lib.mkIf cfg.enable {
    programs = {
      steam.enable = lib.mkDefault cfg.enableSteam;
      prism-launcher = {
        enable = lib.mkDefault cfg.enablePrismLauncher;
        installAdditionalJDK = lib.mkDefault true;
      };
      xivLauncher.enable = lib.mkDefault cfg.enableXIVLauncher;
    };
    suits = {
      emulators.enable = lib.mkDefault cfg.enableEmulators;
      pnp.enable = lib.mkDefault cfg.enablePnP;
    };
  };
}
