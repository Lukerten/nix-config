{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.androidStudio;
  pname = "android-studio";
in {
  options.programs.androidStudio = {
    enable = lib.mkEnableOption "${pname}";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.android-studio;
      description = "The ${pname} package to use.";
    };

    DesktopEntry = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Weather to create a Desktop Entry for ${pname}.";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    # the Default Desktop Entry has a wierd name
    # i just override it with a new one
    xdg.desktopEntries = lib.mkIf cfg.DesktopEntry {
      android-studio = {
        name = "Android Studio";
        comment = "Official Android IDE";
        exec = pname;
        icon = pname;
        genericName = "Android IDE";
        terminal = false;
        type = "Application";
        categories = ["Utility" "TextEditor"];
      };
    };
  };
}
