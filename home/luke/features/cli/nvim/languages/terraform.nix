{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.terraform-ls;
      config = ''
        -- Terraform Language Server
        lspconfig.terraformls.setup {
          capabilities = capabilities,
          on_attach = attach_keymaps,
          cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" },
          filetypes = { 'terraform', 'terraform-vars' },
          root_dir = util.root_pattern('.terraform', '.git'),
        }
      '';
    }
  ];
  formatter = null;
  extraPackages = [];
  extraPlugins = [];
}
