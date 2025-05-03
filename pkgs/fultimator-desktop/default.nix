{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "fultimator";
  version = "1.0.1";
  src = fetchurl {
    url = "https://github.com/fultimator/fultimator-desktop/releases/download/v${version}/Fultimator-Linux-x86_64-${version}.AppImage";
    sha256 = "1zx17mmykzh9959hdd6p426vxcb6hqka00wnnpc8sy2ll4ixf3x5";
  };
  appimageContents = appimageTools.extractType1 {inherit pname version src;};
in
  appimageTools.wrapType1 {
    inherit pname version src;

    extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/${pname}.png -t $out/share/icons/hicolor/512x512/apps
    '';

    meta = {
      description = "Fabula Ultima Character Sheet Manager";
      homepage = "https://fultimator.com/";
      downloadPage = "https://github.com/fultimator/fultimator-desktop";
      license = lib.licenses.gpl3;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      maintainers = with lib.maintainers; [Lukerten];
      platforms = ["x86_64-linux"];
    };
  }
