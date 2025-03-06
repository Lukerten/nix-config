{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.sqls;
      config = ''
        -- SQL Language Server
        local root_dir = require('lspconfig/util').root_pattern('.git', 'flake.nix')(vim.fn.getcwd())
        lspconfig.sqlls.setup {
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = { "${pkgs.sqls}/bin/sqls", "-config", string.format("%s/config.yml", root_dir) },
          filetypes = { 'sql', 'mysql' },
          root_dir = util.root_pattern 'config.yml',
          single_file_support = true,
        }
      '';
    }
  ];
  formatter = {
    package = pkgs.sqlfluff;
    config = ''
      -- SQL formatting: sqlfluff
      table.insert(ls_sources, null_ls.builtins.formatting.sqlfluff.with({
        command = "${pkgs.sqlfluff}/bin/sqlfluff",
      }))
    '';
  };
  extraPackages = [];
  extraPlugins = [];
}
