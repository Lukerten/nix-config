{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.erlang-ls;
      config =
        # lua
        ''
          -- Erlang Language Server
          lspconfig.erlangls.setup{
            cmd = { '${pkgs.erlang-ls}/bin/erlang_ls' },
            filetypes = { 'erlang' },
            root_dir = util.root_pattern('rebar.config', 'erlang.mk', '.git'),
            on_attach = attach_keymaps,
          }
        '';
    }
  ];
  format = [];
  extraPackages = [];
  extraPlugins = [];
}
