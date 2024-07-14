{ config, lib, ... }:
let
  rmHash = lib.removePrefix "#";
  inherit (config.colorscheme) colors harmonized;
in {
  programs.shellcolor = {
    enable = true;
    settings = {
      base00 = "${rmHash colors.surface}"; # bg
      base01 = "${rmHash colors.surface_variant}"; # bg alt 1
      base02 = "${rmHash colors.tertiary_container}"; # bg alt 2
      base03 = "${rmHash colors.primary_container}"; # bright bg
      base04 = "${rmHash colors.on_surface_variant}"; # fg alt 1
      base05 = "${rmHash colors.on_surface}"; # fg
      base06 = "${rmHash colors.on_tertiary_container}"; # fg alt 2
      base07 = "${rmHash colors.on_primary_container}"; # bright fg
      base08 = "${rmHash harmonized.red}"; # red
      base09 = "${rmHash colors.tertiary}"; # accent 1
      base0A = "${rmHash colors.primary}"; # yellow
      base0B = "${rmHash colors.tertiary}"; # green
      base0C = "${rmHash colors.primary}"; # shell snowflake
      base0D = "${rmHash colors.secondary}"; # blue
      base0E = "${rmHash colors.secondary}"; # magenta
      base0F = "${rmHash colors.error_container}"; # export snowflake
    };
  };
}
