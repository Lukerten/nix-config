{
  config,
  lib,
  ...
}: let
  cfg = config.suits.messagers.full;
in {
  options.suits.messagers.full = {
    enable = lib.mkEnableOption "all Messaging Clients";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      element.enable = lib.mkDefault true;
      signal.enable = lib.mkDefault true;
      slack.enable = lib.mkDefault true;
      teams.enable = lib.mkDefault true;
      teamspeak.enable = lib.mkDefault true;
      threema.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault true;
      webex.enable = lib.mkDefault true;
      whatsapp.enable = lib.mkDefault true;
    };
  };
}
