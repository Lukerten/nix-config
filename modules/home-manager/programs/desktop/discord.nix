{
  config,
  pkgs,
  lib,
  ...
}: let
  c = config.colorscheme.colors;
  cfg = config.programs.discord;
  customCSS =
    # css
    ''
      @import url("https://slowstab.github.io/dracula/BetterDiscord/source.css");
      @import url("https://mulverinex.github.io/legacy-settings-icons/dist-native.css");
      .theme-dark, .theme-light, :root {
        --text-default: ${c.on_surface};
        --header-primary: ${c.on_surface};
        --header-secondary: ${c.on_surface_variant};
        --channeltextarea-background: ${c.surface_container};
        --interactive-normal: ${c.surface_container_highest};
        --interactive-active: ${c.on_surface};

        --dracula-primary: ${c.surface};
        --dracula-secondary: ${c.surface_dim};
        --dracula-secondary-alpha: ${c.surface_dim}ee;
        --dracula-tertiary: ${c.surface_bright};
        --dracula-tertiary-alpha: ${c.surface_bright}aa;
        --dracula-primary-light: ${c.surface_bright};

        --dracula-accent: ${c.primary};
        --dracula-accent-alpha: ${c.primary}66;
        --dracula-accent-alpha-alt: ${c.secondary}88;
        --dracula-accent-alpha-alt2: ${c.tertiary}aa;
        --dracula-accent-dark: ${c.primary_fixed_dim};
        --dracula-accent-light: ${c.primary_fixed};
      }

      html.theme-light #app-mount::after {
        content: none;
      }
    '';
in {
  options.programs.discord = {
    enable = lib.mkEnableOption "discord";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.stable.vesktop;
      description = "The code package to use.";
    };

    customCss = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Custom CSS";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."vesktop/themes/base16.css".text = customCSS;
  };
}
