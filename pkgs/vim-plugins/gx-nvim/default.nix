{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  version = "2021-11-15";
  dontBuild = true;
  name = "gx-nvim";
  src = fetchFromGitHub {
    owner = "chrishrb";
    repo = "gx.nvim";
    rev = "f29a87454b02880e0d76264c21be8316224a7395";
    hash = "sha256-QWJ/cPvSyMTJoWLg51BNFf9+/9i7G+nzennpHP/eQ4g=";
  };
}
