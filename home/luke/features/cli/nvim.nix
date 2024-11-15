{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [lazygit xclip neovim nodejs-slim];

  xdg.mimeApps.defaultApplications = {
    "text/english" = "nvim.desktop";
    "text/plain" = "nvim.desktop";
    "text/x-makefile" = "nvim.desktop";
    "text/x-java" = "nvim.desktop";
    "text/x-pascal" = "nvim.desktop";
    "text/x-lua" = "nvim.desktop";
    "text/x-c" = "nvim.desktop";
    "text/x-c++" = "nvim.desktop";
    "text/x-csrc" = "nvim.desktop";
    "text/x-c++hdr" = "nvim.desktop";
    "text/x-c++src" = "nvim.desktop";
    "text/x-tex" = "nvim.desktop";
    "text/x-moc" = "nvim.desktop";
    "text/x-chdr" = "nvim.desktop";
    "text/x-tcl" = "nvim.desktop";
    "application/javascript" = "nvim.desktop";
    "application/json" = "nvim.desktop";
    "application/json+ld" = "nvim.desktop";
    "application/yaml" = "nvim.desktop";
    "application/toml" = "nvim.desktop";
    "application/xml" = "nvim.desktop";
    "application/x-shellscript" = "nvim.desktop";
    "application/x-cmake" = "nvim.desktop";
    "application/x-yaml" = "nvim.desktop";
    "application/x-tex" = "nvim.desktop";
    "application/x-ruby" = "nvim.desktop";
    "application/x-python" = "nvim.desktop";
    "application/x-perl" = "nvim.desktop";
    "application/x-lua" = "nvim.desktop";
  };
}
