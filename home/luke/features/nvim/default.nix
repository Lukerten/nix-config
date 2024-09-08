{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./completions ./core ./lsp ./treesitter ./telescope ./utils ./visuals];

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [lazygit xclip];

  programs.neovim = {enable = true;};

  xdg = {
    desktopEntries = {
      nvim = let
        TermLaunch = ''${lib.getExe pkgs.handlr-regex} launch "x-scheme-handler/terminal"'';
      in {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        exec = "${TermLaunch} nvim %F";
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
          "application/javascript"
          "application/json"
          "application/json+ld"
          "application/yaml"
          "application/toml"
          "application/xml"
          "application/x-shellscript"
          "application/x-cmake"
          "application/x-yaml"
          "application/x-tex"
          "application/x-shellscript"
          "application/x-ruby"
          "application/x-python"
          "application/x-perl"
          "application/x-lua"
          "text/x-c"
          "text/x-c++"
        ];
        terminal = false;
        type = "Application";
        categories = ["Utility" "TextEditor"];
      };
    };

    mimeApps.defaultApplications = {"text/plain" = ["nvim.desktop"];};
  };
}
