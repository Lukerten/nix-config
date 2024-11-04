{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neovim;
  inherit (lib) mkOption mkIf types getExe;
in {
  options.programs.neovim = {
    pvim = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "The pvim package";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.pvim;
        description = "The pvim package";
      };
    };
    createDesktopEntry = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to create a desktop entry for Neovim";
    };
    desktopEntry = let
      entry = {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        exec = "nvim %F";
        icon = "nvim";
        mimeType = [
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
        terminal = true;
        type = "Application";
      };
    in
      mkOption {
        type = types.attrs;
        default = entry;
        description = "The desktop entry for Neovim";
      };
  };
  config = mkIf cfg.enable {
    xdg.desktopEntries = mkIf cfg.createDesktopEntry {
      nvim = cfg.desktopEntry;
    };

    home.packages = mkIf cfg.pvim.enable [cfg.pvim.package];
    programs.zoxide.enable = mkIf cfg.pvim.enable true;
  };
}
