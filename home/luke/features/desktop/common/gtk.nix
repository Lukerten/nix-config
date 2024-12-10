{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) hashString toJSON;
  rendersvg = pkgs.runCommand "rendersvg" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
  materiaTheme = name: colors:
    pkgs.stdenv.mkDerivation {
      name = "generated-gtk-theme";
      src = pkgs.fetchFromGitHub {
        owner = "nana-4";
        repo = "materia-theme";
        rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
        sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
      };
      buildInputs = with pkgs; [
        sassc
        bc
        which
        rendersvg
        meson
        ninja
        nodePackages.sass
        gtk4.dev
        optipng
      ];
      phases = ["unpackPhase" "installPhase"];
      installPhase = ''
        HOME=/build
        chmod 777 -R .
        patchShebangs .
        mkdir -p $out/share/themes
        mkdir bin
        sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

        cat > /build/gtk-colors << EOF
          NAME=${name}
          MATERIA_STYLE_COMPACT=True
          UNITY_DEFAULT_LAUNCHER_STYLE=True

          MATERIA_VIEW=${colors.surface}
          MATERIA_SURFACE=${colors.surface_container}

          TERMINAL_COLOR4=${colors.primary}
          TERMINAL_COLOR5=${colors.error}
          TERMINAL_COLOR9=${colors.inverse_primary}
          TERMINAL_COLOR10=${colors.inverse_primary}
          TERMINAL_COLOR11=${colors.secondary}
          TERMINAL_COLOR12=${colors.tertiary_container}

          BG=${colors.surface}
          HDR_BG=${colors.surface_container}
          FG=${colors.on_surface}
          HDR_FG=${colors.on_surface}
          SEL_BG=${colors.primary}
        EOF

        echo "Changing colors:"
        ./change_color.sh -o ${name} /build/gtk-colors -i False -t "$out/share/themes"
        chmod 555 -R .
      '';
    };
in rec {
  gtk = {
    enable = true;
    font = {
      inherit (config.fontProfiles.regular) name size;
    };
    theme = let
      inherit (config.colorscheme) mode colors;
      name = "generated-${hashString "md5" (toJSON colors)}-${mode}";
    in {
      inherit name;
      package = materiaTheme name (
        lib.mapAttrs (_: v: lib.removePrefix "#" v) colors
      );
    };
    iconTheme = {
      name = "Papirus-${
        if config.colorscheme.mode == "dark"
        then "Dark"
        else "Light"
      }";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      package = pkgs.vimix-cursor-theme;
      name = "Vimix-Cursors${
        if config.colorscheme.mode == "dark"
        then "-White"
        else ""
      }";
      size = 24;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
