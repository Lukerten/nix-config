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
          "application/x-ruby"
          "application/x-python"
          "application/x-perl"
          "application/x-lua"
          "text/x-c"
          "text/x-c++"
        ];
        terminal = true;
        type = "Application";
        categories = ["Utility" "TextEditor"];
      };
    };

    mimeApps.defaultApplications = {
      "text/english" = ["nvim.desktop"];
      "text/plain" = ["nvim.desktop"];
      "text/x-makefile" = ["nvim.desktop"];
      "text/x-c++hdr" = ["nvim.desktop"];
      "text/x-c++src" = ["nvim.desktop"];
      "text/x-chdr" = ["nvim.desktop"];
      "text/x-csrc" = ["nvim.desktop"];
      "text/x-java" = ["nvim.desktop"];
      "text/x-moc" = ["nvim.desktop"];
      "text/x-pascal" = ["nvim.desktop"];
      "text/x-tcl" = ["nvim.desktop"];
      "text/x-c" = ["nvim.desktop"];
      "text/x-c++" = ["nvim.desktop"];
      "text/x-tex" = ["nvim.desktop"];
      "text/x-lua" = ["nvim.desktop"];
      "application/javascript" = ["nvim.desktop"];
      "application/json" = ["nvim.desktop"];
      "application/json+ld" = ["nvim.desktop"];
      "application/yaml" = ["nvim.desktop"];
      "application/toml" = ["nvim.desktop"];
      "application/xml" = ["nvim.desktop"];
      "application/x-shellscript" = ["nvim.desktop"];
      "application/x-cmake" = ["nvim.desktop"];
      "application/x-yaml" = ["nvim.desktop"];
      "application/x-tex" = ["nvim.desktop"];
      "application/x-ruby" = ["nvim.desktop"];
      "application/x-python" = ["nvim.desktop"];
      "application/x-perl" = ["nvim.desktop"];
      "application/x-lua" = ["nvim.desktop"];
    };
  };
}
