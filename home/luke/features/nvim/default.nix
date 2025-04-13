{
  imports = [
    ./completion
    ./copilot
    ./core
    ./highlight
    ./languages
    ./snippets
    ./telescope
    ./terminal
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
          "copilot-lua"
          "nvim-treesitter"
          "blink.cmp"
          "image.nvim"
          "copilot.lua"
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
