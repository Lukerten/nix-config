{config, lib, ...}:let
  cfg = config.suits.pnp;
in {
  options.suits.pnp = {
    enable = lib.mkEnableOption "Pen and Paper";

    enableFultimator = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Fultimator.";
    };

  };
  config = lib.mkIf cfg.enable {
    programs = {
      fultimator-desktop.enable = lib.mkDefault cfg.enableFultimator;
    };
  };
}
