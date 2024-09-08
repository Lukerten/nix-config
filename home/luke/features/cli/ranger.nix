{ pkgs,lib, ... }:{
  programs.ranger.enable = true;

  xdg = {
    desktopEntries = {
      ranger = let
        TermLaunch = ''${lib.getExe pkgs.handlr-regex} launch "x-scheme-handler/terminal"'';
      in {
        name = "Ranger";
        genericName = "File Manager";
        comment = "Manage files";
        exec = "${TermLaunch} ranger %F";
        mimeType = [
          "inode/directory"
        ];
        icon = "file-manager";
        terminal = false;
        type = "Application";
        categories = ["Utility" "FileManager"];
      };
    };
    mimeApps.defaultApplications = {
      "inode/directory" = "ranger.desktop";
    };
  };
}
