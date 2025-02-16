{config, lib, inputs, ...}:{
  programs.waybar = {
    style = let
      inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      inherit (config.colorscheme) colors;
      toRGBA = color: opacity: "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
      # css
    in ''
      * {
        font-family: ${config.fontProfiles.regular.name}, ${config.fontProfiles.monospace.name};
        font-size: 12pt;
        padding: 0;
        margin: 0 0.4em;
      }
      window#waybar {
        padding: 0;
        border-radius: 0.5em;
        background-color: ${toRGBA colors.surface "1.0"};
        color: ${colors.on_surface};
      }
      tooltip {
        color: ${colors.on_surface};
        background-color: ${toRGBA colors.surface "0.9"};
        text-shadow: none;
      }
      .modules-left {
        margin-left: -0.65em;
      }
      .modules-right {
        margin-right: -0.65em;
      }

      #workspaces button {
        background-color: transparent;
        color: ${colors.on_surface};
        padding-left: 0.2em;
        padding-right: 0.2em;
        margin: 0.15em 0;
        transition: background-color 0.2s;
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: ${colors.primary};
        color: ${colors.on_primary};
      }

      #custom-menu {
        background-color: ${colors.surface};
        color: ${colors.primary};
        padding-right: 1.5em;
        padding-left: 1em;
        margin-right: 0;
        border-radius: 0.5em;
      }

      #clock {
        font-family: ${config.fontProfiles.monospace.name};
        background-color: ${colors.surface};
        color: ${colors.primary};
        padding-right: 1em;
        padding-left: 1em;
        margin-left: 0;
        border-radius: 0.5em;
      }
      #custom-currentplayer {
        padding-right: 0;
      }
      #tray {
        color: ${colors.on_surface};
      }
      #custom-gpu, #cpu, #memory {
        margin-left: 0.05em;
        margin-right: 0.55em;
      }

      #taskbar {
          margin: 3px 2px 3px 0px;
          padding:0px;
          border-radius: 5px 5px 5px 5px;
          font-weight: normal;
          font-style: normal;
          opacity:0.8;
      }

      #taskbar button {
          margin:0;
          border-radius: 5px 5px 5px 5px;
          padding: 0px;
      }

      #taskbar.empty {
          background:transparent;
          border:0;
          padding:0;
          margin:0;
      }
    '';
  };
}
