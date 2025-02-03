{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    emoji.enable = true;
    pass.enable = true;
    package = pkgs.wofi.overrideAttrs (oa: {
      patches =
        (oa.patches or [])
        ++ [
          ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
        ];
    });
    settings = {
      hide_scroll = true;
      width = "35%";
      columns = 1;
      line_wrap = "word";
      allow_markup = true;
      allow_images = true;
      show_all = true;
      key_expand = "Tab";
      prompt = "Search: ";
    };
    style = let
      inherit (config.colorscheme) colors;
      fontMonospace = config.fontProfiles.monospace.name;
    in ''
      * {
        font-family: ${fontMonospace}; 
        border-radius: 10px;
      }

      #window {
        background: ${colors.surface};
        margin: auto;
        padding: 10px;
        border: 5px solid ${colors.primary};
        opacity: 0.98;
      }

      #input {
        padding: 2px;
        margin-bottom: 10px;
        border-radius: 5px;
      }

      #outer-box {
        padding: 20px;
      }

      #img {
        margin-right: 6px;
      }

      #entry {
        padding: 10px;
        color: ${colors.on_surface};
        border-radius: 10px;  
      }

      #entry:hover {
        background-color: ${colors.secondary};
        color: ${colors.on_secondary};
      }

      #entry:selected {
        background-color: ${colors.tertiary};
        color: ${colors.surface};
        border-style: none;
      }

      #text {
        margin: 2px;
      }    '';
  };
}
