{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.render-markdown-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('render-markdown').setup({
            heading = {
              signs = { ' ' },
              icons = { '󰫎 ', '󰫎 ', '󰫎 ', '󰫎 ', '󰫎 ', '󰫎 ' },
              backgrounds = {
                'RenderMarkdownH1Bg',
                'RenderMarkdownH2Bg',
                'RenderMarkdownH3Bg',
                'RenderMarkdownH4Bg',
                'RenderMarkdownH5Bg',
                'RenderMarkdownH6Bg',
              },
              foregrounds = {
                'RenderMarkdownH1',
                'RenderMarkdownH2',
                'RenderMarkdownH3',
                'RenderMarkdownH4',
                'RenderMarkdownH5',
                'RenderMarkdownH6',
              },
            },
            bullet = {
              icons = { '', '', '', '' },
            }
          })
        '';
    }
  ];
}
