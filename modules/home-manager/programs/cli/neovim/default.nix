{ pkgs, config, lib, ... }:
let cfg = config.programs.neovim;
in {
  imports = [ ./core ./languages ./telescope ./utils ./visuals ];

  config = lib.mkIf cfg.enable {
    home.sessionVariables.EDITOR = "nvim";
    home.packages = with pkgs; [ lazygit xclip ];

    xdg = {
      desktopEntries = {
        nvim = {
          name = "Neovim";
          genericName = "Text Editor";
          comment = "Edit text files";
          exec = "nvim %F";
          icon = "nvim";
          mimeType = [
            "text/english"
            "text/plain"
            "text/x-makefile"
            "text/x-c++hdr"
            "text/x-c++src"
            "text/x-chdr"
            "text/x-csrc"
            "text/x-java"
            "text/x-moc"
            "text/x-pascal"
            "text/x-tcl"
            "text/x-tex"
            "text/x-lua"
            "application/x-shellscript"
            "text/x-c"
            "text/x-c++"
          ];
          terminal = true;
          type = "Application";
          categories = [ "Utility" "TextEditor" ];
        };
      };
      mimeApps.defaultApplications = { "text/plain" = [ "nvim.desktop" ]; };
    };
  };
}
