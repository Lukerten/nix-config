{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  null_ls = pkgs.vimPlugins.null-ls-nvim;
  null_ls_formatters = [
    # lua
    ''
      -- C/C++ formatting: clang-format
      table.insert(ls_sources, null_ls.builtins.formatting.clang_format.with({
        command = "${pkgs.clang-tools}/bin/clang-format",
        filetypes = { "c", "cpp", "cs", "*.h", "*.hpp", "*.cc", "*.cxx", "*.c++", "*.hh", "*.hxx", "*.h++" },
      }))
    ''
    # lua
    ''
      -- Java formatting: google-java-format
      table.insert(ls_sources, null_ls.builtins.formatting.google_java_format.with({
        command = "${pkgs.google-java-format}/bin/google-java-format",
        filetypes = { "java"},
        args = {
          "--aosp",
          "--skip-removing-unused-imports",
        },
      }))
    ''
    # lua
    ''
      -- PHP formatting: php-cs-fixer
      table.insert(ls_sources, null_ls.builtins.formatting.phpcsfixer.with({
        filetypes = { "php" },
        command = "${pkgs.php83Packages.php-cs-fixer}/bin/php-cs-fixer",
      }))
    ''
    # lua
    ''
      -- Kotlin formatting: ktlint
      table.insert(ls_sources, null_ls.builtins.formatting.ktlint.with({
        filetypes = { "kotlin" },
        command = "${pkgs.ktlint}/bin/ktlint",
      }))
    ''
    # lua
    ''
      -- Lua formatting: stylua
      table.insert(ls_sources, null_ls.builtins.formatting.stylua.with({
        filetypes = { "lua" },
        command = "${pkgs.stylua}/bin/stylua",
      }))
    ''
    # lua
    ''
      -- Python formatting: black
      table.insert(ls_sources, null_ls.builtins.formatting.black.with({
        filetypes = { "python" },
        command = "${pkgs.black}/bin/black",
      }))
    ''
    # lua
    ''
      -- SQL formatting: sqlfluff
      table.insert(ls_sources, null_ls.builtins.formatting.sqlfluff.with({
        filetypes = { "sql", "mysql", "pgsql" },
        command = "${pkgs.sqlfluff}/bin/sqlfluff",
      }))
    ''
    # lua
    ''
      -- TypeScript formatting: prettier
      table.insert(ls_sources, null_ls.builtins.formatting.prettier.with({
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "jsonc", "yaml", "html"},
        command = "${pkgs.nodePackages.prettier}/bin/prettier",
      }))
    ''
    # lua
    ''
      -- Nix formatting: alejandra
      table.insert(ls_sources, null_ls.builtins.formatting.alejandra.with({
        filetypes = { "nix" },
        command = "${pkgs.alejandra}/bin/alejandra",
      }))
    ''
  ];
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = null-ls-nvim;
      type = "lua";
      config =
        # lua
        ''
          local null_ls = require("null-ls")
          local null_helpers = require("null-ls.helpers")
          local null_methods = require("null-ls.methods")
          local ls_sources = {}
          -- Formatters
          ${concatMapStringsSep "\n" (s: s) null_ls_formatters}

          require('null-ls').setup({
            diagnostics_format = "[#{m}] #{s} (#{c})",
            debounce = 250,
            default_timeout = 5000,
            sources = ls_sources,
            on_attach=default_on_attach
          })

        '';
    }
  ];
}
