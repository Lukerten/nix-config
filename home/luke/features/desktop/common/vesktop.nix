{config, ...}:
with config.colorscheme.colors; {
  services.arrpc = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };

  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = true;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = true;
      tray = true;
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };
  };

  xdg.configFile."vesktop/themes/dracula.css".text =
    # scss
    ''
      /**
       * @name dynamic Dracula
       * @description A dark, rounded discord theme.
       * @author Lukerten
       * @version 1.0.0
      */
      @import url("https://slowstab.github.io/dracula/BetterDiscord/source.css");
      @import url("https://mulverinex.github.io/legacy-settings-icons/dist-native.css");
      .theme-dark, .theme-light, :root {
        --text-default: ${on_surface};
        --header-primary: ${on_surface};
        --header-secondary: ${on_surface_variant};
        --channeltextarea-background: ${surface_container};
        --interactive-normal: ${on_surface};
        --interactive-active: ${tertiary};

        --dracula-primary: ${surface};
        --dracula-secondary: ${surface_dim};
        --dracula-secondary-alpha: ${surface_dim}ee;
        --dracula-tertiary: ${surface_bright};
        --dracula-tertiary-alpha: ${surface_bright}aa;
        --dracula-primary-light: ${surface_bright};

        --dracula-accent: ${primary};
        --dracula-accent-alpha: ${primary}66;
        --dracula-accent-alpha-alt: ${secondary}88;
        --dracula-accent-alpha-alt2: ${tertiary}aa;
        --dracula-accent-dark: ${primary};
        --dracula-accent-light: ${primary_fixed};
      }

      html.theme-light #app-mount::after {
        content: none;
      }
    '';
}
