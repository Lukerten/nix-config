{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./completions ./core ./lsp ./treesitter ./telescope ./utils ./visuals];

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.COLORTERM = "truecolor";
  home.packages = with pkgs; [lazygit xclip];
  programs.neovim.enable = true;
  programs.pvim.enable = true;
  xdg = let
    mime = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-java"
      "text/x-pascal"
      "text/x-lua"
      "text/x-c"
      "text/x-c++"
      "text/x-csrc"
      "text/x-csharp"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-tex"
      "text/x-moc"
      "text/x-chdr"
      "text/x-tcl"
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
    ];
    mimeMap = lib.lists.foldl' (acc: type: acc // {"${type}" = "nvim.desktop";}) {} mime;
  in {
    desktopEntries = {
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        exec = "nvim %F";
        icon = "nvim";
        mimeType = mime;
        terminal = true;
        type = "Application";
      };
    };
    mimeApps.defaultApplications = mimeMap;
  };
}
