{ config, lib, pkgs, ... }:
let inherit (config.colorscheme) colors harmonized;
in {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi.overrideAttrs
      (oa: { patches = (oa.patches or [ ]) ++ [ ./wofi-run-shell.patch ]; });
    settings = {
      hide_scroll = true;
      width = "40%";
      columns = 1;
      lines = 8;
      line_wrap = "word";
      allow_markup = true;
      allow_images = true;
      show_all = true;
      key_expand = "Tab";
      prompt = "  Search ";
    };

    style = ''
      * {
        font-family: JetBrainsMono;
        color: ${colors.on_surface};
        background: ${colors.surface};
        border-radius: 10px;
      }

      #window {
        background: ${colors.surface};
        margin: auto;
        padding: 10px;
        border-radius: 20px;
        border: 2px solid ${colors.primary};
      }

      #input {
        visibility: hidden;
      }

      #outer-box {
        padding: 20px;
      }

      #img {
        margin-right: 6px;
      }

      #entry {
        padding: 10px;
        border-radius: 15px;
      }

      #entry:selected {
        background-color: ${colors.surface};
      }

      #text {
        margin: 2px;
      }

      #text:selected {
        color: ${colors.primary};
      }


    '';
  };
  home.packages = let inherit (config.programs.password-store) package enable;
  in lib.optional enable (pkgs.pass-wofi.override { pass = package; });
}
