{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "remote-nvim";
  version = "2024-09-19";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "amitds1997";
    repo = "remote-nvim.nvim";
    rev = "ffbf91f6132289a8c43162aba12c7365c28d601c";
    sha256 = "sha256-8gKQ7DwubWKfoXY4HDvPeggV+kxhlpz3yBmG9+SZ8AI=";
  };
  meta.homepage = "https://github.com/AckslD/nvim-FeMaco.lua";
}
