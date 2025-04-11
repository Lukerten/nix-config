{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings.formatters_by_ft.bash = ["shfmt"];
      conform-nvim.settings.formatters_by_ft.sh = ["shfmt"];
      lsp.servers.bashls.enable = true;
    };
    extraPackages = with pkgs; [shfmt];
  };
}
