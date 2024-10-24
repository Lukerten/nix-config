{
  config,
  lib,
  ...
}: let
  cfg = config.suits.productivity.notes;
in {
  options.suits.productivity.notes = {
    enable = lib.mkEnableOption "Note Taking and Writing";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      obsidian.enable = lib.mkDefault true;
      office.enable = lib.mkDefault true;
    };
  };
}
