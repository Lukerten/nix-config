{ pkgs, config, lib, ... }: {
  imports =
    [ ./completions ./core ./lsp ./treesitter ./telescope ./utils ./visuals ];

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [ lazygit xclip ];

  programs.neovim = { enable = true; };

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
}
