{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  null_ls = pkgs.vimPlugins.null-ls-nvim;
  null_ls_formatters = [
    # clang-format
    ''
      -- C/C++ formatting: clang-format
      table.insert(ls_sources, null_ls.builtins.formatting.clang_format.with({
        command = "${pkgs.clang-tools}/bin/clang-format",
        filetypes = { "c", "cpp", "cs", "*.h", "*.hpp", "*.cc", "*.cxx", "*.c++", "*.hh", "*.hxx", "*.h++" },
      }))
    ''
    # google-java-format
    ''
      -- Java formatting: google-java-format
      table.insert(ls_sources, null_ls.builtins.formatting.google_java_format.with({
        command = "${pkgs.google-java-format}/bin/google-java-format",
        filetypes = { "java" },
        args = {
          "--aosp",
          "--skip-removing-unused-imports",
        },
      }))
    ''
    # kotlin
    ''
      -- Kotlin formatting: ktlint
      table.insert(ls_sources, null_ls.builtins.formatting.ktlint.with({
        command = "${pkgs.ktlint}/bin/ktlint",
      }))
    ''
    # lua
    ''
      -- Lua formatting: stylua
      table.insert(ls_sources, null_ls.builtins.formatting.stylua.with({
        command = "${pkgs.stylua}/bin/stylua",
      }))
    ''
    # nix
    ''
      -- Nix formatting: alejandra
      table.insert(ls_sources, null_ls.builtins.formatting.alejandra.with({
        command = "${pkgs.alejandra}/bin/alejandra",
      }))
    ''
    # python
    ''
      -- Python formatting: black
      table.insert(ls_sources, null_ls.builtins.formatting.black.with({
        command = "${pkgs.black}/bin/black",
      }))
    ''
    # sql
    ''
      -- SQL formatting: sqlfluff
      table.insert(ls_sources, null_ls.builtins.formatting.sqlfluff.with({
        command = "${pkgs.sqlfluff}/bin/sqlfluff",
      }))
    ''
    # ts
    ''
      -- TypeScript formatting: prettier
      table.insert(ls_sources, null_ls.builtins.formatting.prettier.with({
        command = "${pkgs.nodePackages.prettier}/bin/prettier",
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

          require('null-ls').setup({
            diagnostics_format = "[#{m}] #{s} (#{c})",
            debounce = 250,
            default_timeout = 5000,
            sources = ls_sources,
            on_attach=default_on_attach
          })

          -- Formatters
          ${concatMapStringsSep "\n" (s: s) null_ls_formatters}
        '';
    }
  ];
}
