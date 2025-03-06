{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.phpactor;
      config = ''
        -- PHP Language Server
        lspconfig.phpactor.setup{
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = {'${pkgs.phpactor}/bin/phpactor', 'language-server'},
          filetypes = {'php'},
          root_dir = function(pattern)
            local cwd = vim.loop.cwd()
            local root = util.root_pattern('composer.json', '.git', 'phpactor.json', '.git', '.gitignore')(cwd)
            return util.path.is_descendant(cwd, root) and cwd or root
          end;
        }
      '';
    }
  ];
  formatter = {
    package = pkgs.php83Packages.php-cs-fixer;
    config = ''
      -- PHP formatting: php-cs-fixer
      table.insert(ls_sources, null_ls.builtins.formatting.phpcsfixer.with({
        command = "${pkgs.php83Packages.php-cs-fixer}/bin/php-cs-fixer",
      }))
    '';
  };
  extraPackages = [];
  extraPlugins = [];
}
