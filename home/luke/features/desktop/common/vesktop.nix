{
  config,
  pkgs,
  lib,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
  inherit (config.colorscheme) colors harmonized;
  inherit (config.fontProfiles) regular;
  customCSS = # scss
    ''
    /**
     * @name dynamic midnight
     * @description A dark, rounded discord theme.
     * @author Lukerten
     * @version 1.0.0
    */
    @import url('https://refact0r.github.io/midnight-discord/midnight.css');

    :root {
      --font: '${regular.name}';
      --corner-text: 'Midnight';

      --online-indicator: ${harmonized.green};
      --dnd-indicator: ${harmonized.red};
      --idle-indicator: ${harmonized.yellow};
      --streaming-indicator: ${harmonized.magenta};

      --accent-1: ${colors.primary};
      --accent-2: ${colors.primary};
      --accent-3: ${colors.tertiary};
      --accent-4: ${colors.tertiary_fixed};
      --accent-5: ${colors.tertiary_fixed_dim};
      --mention: ${colors.tertiary_fixed}44;
      --mention-hover: ${colors.tertiary}44;

      /* text colors */
      --text-0: ${colors.on_surface};
      --text-1: ${colors.primary };
      --text-2: ${colors.on_surface_variant};
      --text-3: ${colors.on_surface};
      --text-4: ${colors.on_surface};
      --text-5: ${colors.outline};

      /* background and dark colors */
      --bg-1: ${colors.surface};
      --bg-2: ${colors.surface_container};
      --bg-3: ${colors.surface_container};
      --bg-4: ${colors.surface};
      --hover: ${colors.surface};
      --active: ${colors.surface};
      --message-hover: ${colors.surface};

      --spacing: 12px;

      /* animations */
      --list-item-transition: 0.2s ease; /* channels/members/settings hover transition */
      --unread-bar-transition: 0.2s ease; /* unread bar moving into view transition */
      --moon-spin-transition: 0.4s ease; /* moon icon spin */
      --icon-spin-transition: 1s ease; /* round icon button spin (settings, emoji, etc.) */

      /* corner roundness (border-radius) */
      --roundness-xl: 8px; /* roundness of big panel outer corners */
      --roundness-l: 8px; /* popout panels */
      --roundness-m: 4px; /* smaller panels, images, embeds */
      --roundness-s: 2px; /* members, settings inputs */
      --roundness-xs: 2px; /* channels, buttons */
      --roundness-xxs: 2px; /* searchbar, small elements */

      --discord-icon: none; /* discord icon */
      --moon-icon: block; /* moon icon */
      --moon-icon-url: url('https://upload.wikimedia.org/wikipedia/commons/c/c4/Font_Awesome_5_solid_moon.svg'); /* custom icon url */
      --moon-icon-size: auto;

      /* filter uncolorable elements to fit theme */
      /* this is static for now since its way to complicated to make dynamic */
      --login-bg-filter: saturate(0.3) hue-rotate(-15deg) brightness(0.4); /* login background artwork */
      --green-to-accent-3-filter: hue-rotate(56deg) saturate(1.43); /* add friend page explore icon */
      --blurple-to-accent-3-filter: hue-rotate(304deg) saturate(0.84) brightness(1.2);
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
