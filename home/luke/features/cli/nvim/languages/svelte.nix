{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.svelte-language-server;
      config =
        # lua
        ''
          -- Svelte Language Server
          lspconfig.svelte.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.svelte-language-server}/bin/svelteserver','--stdio'},
            root_dir = util.root_pattern('package.json', '.git'),
            filetypes = { 'svelte' },
          }
        '';
    }
  ];
  format = [];
  extraPackages = [];
  extraPlugins = [];
}
