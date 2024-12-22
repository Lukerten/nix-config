{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "copilot-lua";
  version = "2024-12-22";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "zbirenbaum";
    repo = "copilot.lua";
    rev = "d3783b9283a7c35940ed8d71549030d5f5f9f980";
    sha256 = "sha256-erRL8bY/zuwuCZfttw+avTrFV7pjv2H6v73NzY2bymM=";
  };
  meta.homepage = "https://github.com/zbirenbaum/copilot.lua";
}
