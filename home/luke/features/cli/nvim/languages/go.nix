{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.gopls;
      config =
        # lua
        ''
          lspconfig.gopls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.gopls}/bin/gopls'};
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
              },
            },
          }
          -- organize imports sync
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
              vim.lsp.buf.format()
              vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
              vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
            end,
          })
        '';
    }
  ];
  formatter = null;
  extraPackages = with pkgs; [
    go
    golangci-lint
  ];
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = go-nvim;
      type = "lua";
      config =
        # lua
        ''
          -- Setup Go.nvim plugin
          require("go").setup()
          require("go.format").goimports()

          local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
             require('go.format').goimports()
            end,
            group = format_sync_grp,
          })
        '';
    }
  ];
}
