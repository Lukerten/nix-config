{config, ...}: {
  programs.imv = {
    enable = true;
    settings = {
      options.background = config.colorscheme.colors.surface;
    };
  };
  xdg.desktopEntries = {
    imv = {
      exec = "imv %F";
      name = "imv";
      mimeType = [
        "image/jpeg"
        "image/png"
        "image/gif"
        "image/bmp"
        "image/svg+xml"
        "image/tiff"
        "image/x-xcf"
        "image/x-xbitmap"
        "image/x-xpixmap"
      ];
      terminal = false;
      type = "Application";
      categories = ["Utility" "FileManager"];
      settings.NoDisplay = "true";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = ["imv.desktop"];
    "image/png" = ["imv.desktop"];
    "image/gif" = ["imv.desktop"];
    "image/bmp" = ["imv.desktop"];
    "image/svg+xml" = ["imv.desktop"];
    "image/tiff" = ["imv.desktop"];
    "image/x-xcf" = ["imv.desktop"];
    "image/x-xbitmap" = ["imv.desktop"];
    "image/x-xpixmap" = ["imv.desktop"];
  };
}
