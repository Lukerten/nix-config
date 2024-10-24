{
  config,
  lib,
  ...
}: let
  cfg = config.suits.messagers.minimal;
in {
  options.suits.messagers.minimal = {
    enable = lib.mkEnableOption "minimal Messaging Clients";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      element.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault true; 
    };
  };
}
