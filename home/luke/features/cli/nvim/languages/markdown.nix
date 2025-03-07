{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.marksman;
      config =
        # lua
        ''
          -- Markdown Language Server
          lspconfig.marksman.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.marksman}/bin/marksman', 'server'},
            filetypes = { 'markdown' },
            root_dir = util.root_pattern('.git', 'markdown.config.json'),
          }
        '';
    }
  ];
  formatter = {
    package = pkgs.mdformat;
    config =
      # lua
      ''
        -- Markdown formatting: mdformat
        table.insert(ls_sources, null_ls.builtins.formatting.mdformat.with({
          command = {"${pkgs.mdformat}/bin/mdformat", "--wrap", "80"},
        }))
      '';
  };
  extraPackages = [];
  extraPlugins = [];
}
