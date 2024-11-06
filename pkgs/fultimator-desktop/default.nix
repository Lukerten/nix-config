{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "fultimator";
  version = "0.1.3-prerelease";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/fultimator/fultimator-desktop/releases/download/v${version}/Fultimator-${version}.AppImage";
    sha256 = "tMoJaUb3wdggnXFzhzV5gKAlHZ8OjdOVF+XCq4CYKPE=";
  };
  appimageContents = appimageTools.extractType1 {inherit name src;};
in
  appimageTools.wrapType1 {
    inherit name src;
    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/${pname}.png -t $out/share/icons/hicolor/512x512/apps
    '';
    meta = {
      description = "Fabula Ultima Character Sheet Manager";
      homepage = "https://github.com/ZUGFeRD/quba-viewer";
      downloadPage = "https://github.com/fultimator/fultimator-desktop";
      license = lib.licenses.gpl3;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      maintainers = with lib.maintainers; [Lukerten];
      platforms = ["x86_64-linux"];
    };
  }
