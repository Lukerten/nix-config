{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.androidStudio;
  displayName = "Android Studio";
  pname = "android-studio";
in {
  options.programs.androidStudio = {
    enable = mkEnableOption "${pname}";

    package = mkOption {
      type = types.package;
      default = pkgs.android-studio;
      description = "The ${pname} package to use.";
    };

    DesktopEntry = mkOption {
      type = types.bool;
      default = true;
      description = "Weather to create a Desktop Entry for ${pname}.";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # the Default Desktop Entry has a wierd name
    # i just override it with a new one
    xdg.desktopEntries = mkIf cfg.DesktopEntry {
      android-studio = {
        name = displayName;
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
