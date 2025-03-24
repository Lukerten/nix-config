{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.sqls;
      config =
        # lua
        ''
          -- SQL Language Server
          local root_dir = require('lspconfig/util').root_pattern('.git', 'flake.nix')(vim.fn.getcwd())
          lspconfig.sqlls.setup {
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = { "${pkgs.sqls}/bin/sqls", 'up', '--method', 'stdio' },
            filetypes = { 'sql', 'mysql' },
            root_dir = util.root_pattern '.sqllsrc.json',
            single_file_support = true,
          }
        '';
    }
  ];
  format = [
    {
      package = pkgs.sql-formatter;
      config =
        # lua
        ''
          -- SQL formatting: sqlfluff
          table.insert(ls_sources, none_ls.builtins.formatting.sql_formatter.with({
            command = "${pkgs.sql-formatter}/bin/sql-formatter",
            filetypes = { "sql" },
          }))
        '';
    }
  ];
  extraPackages = [];
  extraPlugins = [];
}
