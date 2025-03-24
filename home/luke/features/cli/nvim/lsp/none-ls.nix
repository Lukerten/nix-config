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
        plugin = pkgs.vimPlugins.none-ls-nvim;
        type = "lua";
        config =
          # lua
          ''
            -- Null-ls configuration
            local none_ls = require("null-ls")
            local none_helpers = require("null-ls.helpers")
            local none_methods = require("null-ls.methods")
            local ls_sources = {}
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- Formatters
            ${concatMapStringsSep "\n" (cfg: cfg.config) formatterConfigs}

            require('null-ls').setup({
              diagnostics_format = "[#{m}] #{s} (#{c})",
              debounce = 250,
              default_timeout = 5000,
              sources = ls_sources,
              on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                      vim.lsp.buf.format()
                    end,
                  })
                end
              end,
            })
          '';
      }
    ];
  };
}
