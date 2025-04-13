{
  imports = [
    ./completion
    ./copilot
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
        enable = false;
        standalonePlugins = [
          "neorg"
          "copilot-lua"
          "nvim-treesitter"
          "blink.cmp"
          "copilot.lua"
        ];
      };
      byteCompileLua.enable = false;
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    plugins.lz-n.enable = true;
  };
}
