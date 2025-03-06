{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  languages = import ../languages {inherit pkgs lib;};
  formatterConfigs = languages.formatterConfigs;
in {
  programs.neovim = {
    plugins = [
      {
        plugin = pkgs.vimPlugins.null-ls-nvim;
        type = "lua";
        config =
          # lua
          ''
            local null_ls = require("null-ls")
            local null_helpers = require("null-ls.helpers")
            local null_methods = require("null-ls.methods")
            local ls_sources = {}

            -- Formatters
            ${concatMapStringsSep "\n" (cfg: cfg.config) formatterConfigs}

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
  };
}
