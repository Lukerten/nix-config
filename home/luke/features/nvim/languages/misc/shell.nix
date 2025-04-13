{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings.formatters_by_ft.bash = ["shfmt"];
      conform-nvim.settings.formatters_by_ft.sh = ["shfmt"];
      lsp.servers.bashls.enable = true;

      luasnip.fromSnipmate = [
        {
          paths = ../../snippets/store/snippets/sh.snippets;
          include = ["sh"];
        }
        {
          paths = ../../snippets/store/snippets/bash.snippets;
          include = ["bash"];
        }
        {
          paths = ../../snippets/store/snippets/zsh.snippets;
          include = ["zsh"];
        }
      ];
    };
    extraPackages = with pkgs; [shfmt];
  };
}
