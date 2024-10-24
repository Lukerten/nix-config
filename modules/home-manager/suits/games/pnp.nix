{
  config,
  lib,
  ...
}: let
  cfg = config.suits.games.pnp;
in {
  options.suits.games.pnp = {
    enable = lib.mkEnableOption "Pen and Paper";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      fultimatorDesktop.enable = lib.mkDefault true;
    };
  };
}
