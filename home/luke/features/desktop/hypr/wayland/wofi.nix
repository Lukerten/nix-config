{ config, lib, pkgs, ... }:
let
  inherit (config.colorscheme) colors;
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs
      (oa: { patches = (oa.patches or [ ]) ++ [ ./wofi-run-shell.patch ]; });
    settings = {
      hide_scroll = true;
      width = "45%";
      columns = 1;
      lines = 11;
      line_wrap = "word";
      term="kitty";
      allow_markup = true;
      allow_images = true;
      show_all = true;
      key_expand = "Tab";
      prompt = "Search ";
    };

    style = ''
      * {
        font-family: JetBrainsMono;
        color: ${colors.on_surface};
        border-radius: 10px;
      }

      #window {
        background: ${colors.surface};
        margin: auto;
        padding: 10px;
        border: 5px solid ${colors.on_tertiary_fixed};
        opacity: 0.98;
      }

      #input {
        padding: 10px;
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
        border-radius: 10px;
      }

      #entry:selected {
        background-color: ${colors.on_tertiary_fixed};
        border-style: none;
      }

      #text {
        margin: 2px;
      }    '';
  };
  home.packages = let inherit (config.programs.password-store) package enable;
  in lib.optional enable (pkgs.pass-wofi.override { pass = package; });
}
