{
  config,
  lib,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
  inherit (config.colorscheme) colors;
  customCSS =
    # css
    ''
      @import url("https://slowstab.github.io/dracula/BetterDiscord/source.css");
      @import url("https://mulverinex.github.io/legacy-settings-icons/dist-native.css");
      .theme-dark, .theme-light, :root {
        --text-default: ${colors.on_surface};
        --header-primary: ${colors.on_surface};
        --header-secondary: ${colors.on_surface_variant};
        --channeltextarea-background: ${colors.surface_container};
        --interactive-normal: ${colors.on_surface};
        --interactive-active: ${colors.tertiary};

        --dracula-primary: ${colors.surface};
        --dracula-secondary: ${colors.surface_dim};
        --dracula-secondary-alpha: ${colors.surface_dim}ee;
        --dracula-tertiary: ${colors.surface_bright};
        --dracula-tertiary-alpha: ${colors.surface_bright}aa;
        --dracula-primary-light: ${colors.surface_bright};

        --dracula-accent: ${colors.primary};
        --dracula-accent-alpha: ${colors.primary}66;
        --dracula-accent-alpha-alt: ${colors.secondary}88;
        --dracula-accent-alpha-alt2: ${colors.tertiary}aa;
        --dracula-accent-dark: ${colors.primary_fixed_dim};
        --dracula-accent-light: ${colors.primary_fixed};
      }

      html.theme-light #app-mount::after {
        content: none;
      }
    '';
in {
  programs.vesktop = {
    enable = true;
    customCss = {
      enable = true;
      text = customCSS;
      file = "base16";
    };
  };

  services.arrpc = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
}
