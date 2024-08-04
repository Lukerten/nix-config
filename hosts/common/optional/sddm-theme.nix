{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "3ximus";
    repo = "aerial-sddm-theme";
    rev = "74fb9d0b2cfc3b63f401606b416e908a71efc447";
    sha256 = "0r52rr68am383nxhg86d61n1lv6mbbmfrga94ayynkxfbnz2fxjx";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
