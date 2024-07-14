{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = null-ls-nvim;
    type = "lua";
    config = # lua
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
      '';
  }];
}
