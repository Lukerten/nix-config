{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "beamer-template";
  version = "1.0";

  src = ./.;

  buildInputs = with pkgs; [
    texlive.combined.scheme-medium
    texlive.beamer
    texlive.xcolor
    texlive.graphics
    texlive.fontspec
    texlive.biblatex
  ];

  buildPhase = ''
    pdflatex -output-directory=out src/main.tex
    pdflatex -output-directory=out src/main.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp out/main.pdf $out/presentation.pdf
  '';
}
