{
  config,
  lib,
  ...
}: let
  rmHash = lib.removePrefix "#";
  inherit (config.colorscheme) colors harmonized;
in {
  programs.shellcolor = {
    enable = true;
    settings = {
      base00 = "${rmHash colors.surface}";                # bg
      base01 = "${rmHash colors.shadow}";                 # bg alt 1
      base02 = "${rmHash colors.surface_container}";      # bg alt 2
      base03 = "${rmHash colors.surface_bright}";         # bright bg
      base05 = "${rmHash colors.on_surface}";             # fg
      base04 = "${rmHash colors.on_surface_variant}";     # fg alt 1
      base06 = "${rmHash colors.on_background}";          # fg alt 2
      base07 = "${rmHash colors.shadow}";                 # bright fg
      base08 = "${rmHash harmonized.red}";                # col 1  --> RED
      base0B = "${rmHash colors.primary}";                # col 2  --> GREEN
      base0A = "${rmHash colors.inverse_primary}";        # col 3  --> YELLOW
      base0D = "${rmHash colors.tertiary}";               # col 4  --> BLUE
      base0E = "${rmHash colors.on_tertiary}";            # col 5  --> MAGENTA
      base0C = "${rmHash colors.on_primary_fixed}";       # col 6  --> CYAN
      base09 = "${rmHash colors.error}";                  # error
      base0F = "${rmHash colors.error_container}";        # error alt
    };
  };
}
