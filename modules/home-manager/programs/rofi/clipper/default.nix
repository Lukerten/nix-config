{pkgs,lib,config, ...}:let
  cfg = config.programs.rofi;
  rofi-clipper = pkgs.writeShellScriptBin "rofi-clipper" ''
    selected=$(cliphist list | rofi -dmenu -theme $HOME/.config/rofi/clipper.rasi) && echo "$selected" | cliphist decode | wl-copy
  '';
in {
  options.programs.rofi = {
    enableClipper = lib.mkEnableOption "rofi-clipper";
    clipperScript = lib.mkOption {
      type = lib.types.package;
      default = rofi-clipper;
    };
  };

  config = lib.mkIf cfg.enableLauncher {
    home.packages = [ cfg.clipperScript ];
    xdg.configFile."rofi/clipper.rasi".source = ./clipper.rasi;
  };
}
