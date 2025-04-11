{
  imports = [
    ./completion
    ./core
    ./languages
    ./telescope
    ./utils
    ./visual
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.useGlobalPackages = true;
    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "neorg"
          "nvim-treesitter"
        ];
      };
      byteCompileLua.enable = true;
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    plugins.lz-n.enable = true;
  };
}
