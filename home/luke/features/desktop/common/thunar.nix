{
  xdg.desktopEntries = {
    thunar = {
      name = "Thunar";
      genericName = "File Manager";
      comment = "Manage files and folders";
      exec = "thunar";
      icon = "thunar";
      terminal = false;
      type = "Application";
      categories = [ "Utility" "FileManager" ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
  };
}
