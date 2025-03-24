{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.python312Packages.python-lsp-server;
      config =
        # lua
        ''
          -- Python Language Server
          lspconfig.pylsp.setup{
            cmd = { '${pkgs.python312Packages.python-lsp-server}/bin/pylsp' },
            filetypes = { 'python' },
            root_dir = function(fname)
              local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
              }
              return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
            end,
            single_file_support = true,
            settings = {
              pylsp = {
                plugins = {
                  ruff = {
                    severities = { ["F401"] = "W" }
                  }
                },
              },
              capabilities = {
                experimental = {
                  inlayHintProvider = true,
                }
              },
            },
          }
        '';
    }
  ];
  formatter = {
    package = pkgs.black;
    config =
      # lua
      ''
        -- Python formatting: black
        table.insert(ls_sources, none_ls.builtins.formatting.black.with({
          command = "${pkgs.black}/bin/black",
        }))
      '';
  };
  extraPackages = [];
  extraPlugins = [];
}
