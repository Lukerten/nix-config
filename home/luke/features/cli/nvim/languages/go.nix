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
                buildFlags = {"-tags=unittest wireinject integrationtest systemtest ruleguard"},
              },
            },
          }
        '';
    }
  ];

  format = [];

  dap = [
    {
      config =
        #lua
        ''
          -- Go
          require('dap-go').setup()
        '';
      package = pkgs.vimPlugins.nvim-dap-go;
    }
  ];

  extraPackages = with pkgs; [
    go
    golangci-lint
    gotools
  ];

  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.go-nvim;
      type = "lua";
      config =
        #lua
        ''
          require("go").setup()
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
