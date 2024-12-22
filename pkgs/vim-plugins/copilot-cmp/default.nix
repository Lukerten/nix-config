{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "copilot-cmp";
  version = "2024-12-22";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "zbirenbaum";
    repo = "copilot-cmp";
    rev = "15fc12af3d0109fa76b60b5cffa1373697e261d1";
    sha256 = "sha256-erRL8bY/zuwuCZfttw+avTrFV7pjv2H6v73NzY2bymM=";
  };
  meta.homepage = "https://github.com/zbirenbaum/copilot-cmp";
}
