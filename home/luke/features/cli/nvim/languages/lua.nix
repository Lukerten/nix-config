{pkgs, ...}: {
  lsp = [];
  formatter = {
    package = pkgs.stylua;
    config =
      # lua
      ''
        -- Lua formatting: stylua
        table.insert(ls_sources, none_ls.builtins.formatting.stylua.with({
          command = "${pkgs.stylua}/bin/stylua",
        }))
      '';
  };
  extraPackages = [];
  extraPlugins = with pkgs; [
    vimPlugins.lazydev-nvim
  ];
}
