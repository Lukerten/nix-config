{
  programs.mpv.enable = true;

  xdg.desktopEntries = {
    mpv = {
      exec = "mpv %F";
      name = "mpv";
      mimeType = [
        "audio/mpeg"
        "audio/x-wav"
        "video/mp4"
        "video/mpeg"
        "video/ogg"
      ];
      terminal = false;
      type = "Application";
      categories = ["Utility" "FileManager"];
      settings.NoDisplay = "true";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "audio/mpeg" = ["mpv.desktop"];
    "audio/x-wav" = ["mpv.desktop"];
    "video/mp4" = ["mpv.desktop"];
    "video/mpeg" = ["mpv.desktop"];
    "video/ogg" = ["mpv.desktop"];
  };
}
