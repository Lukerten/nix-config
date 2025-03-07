{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  languages = import ../languages {inherit pkgs lib;};
  lspConfigs = languages.lspConfigs;
  extraPackages = languages.extraPackages;
  extraPlugins = languages.extraPlugins;
in {
  programs.neovim = {
    extraPackages = map (cfg: cfg.package) lspConfigs ++ extraPackages;
    plugins = with pkgs.vimPlugins;
      [
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config =
            # lua
            ''
              local lspconfig = require('lspconfig')
              local util = require('lspconfig.util')
              local async = require 'lspconfig.async'
              local capabilities = vim.lsp.protocol.make_client_capabilities()

              -- Default Keymap Options
              local attach_keymaps = function(client, bufnr)
                vim.lsp.inlay_hint.enable(true)
                vim.keymap.set("n", "<leader>Lgc", "<cmd> lua vim.lsp.buf.declaration()<cr>",default_opts("Go to declaration", bufnr))
                vim.keymap.set("n", "<leader>Lgd", "<cmd> lua vim.lsp.buf.definition()<cr>",default_opts("Go to definition", bufnr))
                vim.keymap.set("n", "<leader>Lgt", "<cmd> lua vim.lsp.buf.type_definition()<cr>",default_opts("Go to type definition", bufnr))
                vim.keymap.set("n", "<leader>Lgr", "<cmd> lua vim.lsp.buf.references()<cr>",default_opts("Go to references", bufnr))
                vim.keymap.set("n", "<leader>Lgn", "<cmd> lua vim.lsp.diagnostic.goto_next()<cr>",default_opts("next diagnostic", bufnr))
                vim.keymap.set("n", "<leader>Lgp", "<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>",default_opts("previous diagnostic", bufnr))
                vim.keymap.set("n", "<leader>Lgi", "<cmd> lua vim.lsp.buf.implementation()<cr>",default_opts("Go to implementation", bufnr))
                vim.keymap.set("n", "<leader>Lwa", "<cmd> lua vim.lsp.buf.add_workspace_folder()<cr>",default_opts("Add workspace folder", bufnr))
                vim.keymap.set("n", "<leader>Lwr", "<cmd> lua vim.lsp.buf.remove_workspace_folder()<cr>",default_opts("Remove workspace folder", bufnr))
                vim.keymap.set("n", "<leader>Lwl", "<cmd> lua vim.lsp.buf.list_workspace_folders()<cr>",default_opts("List workspace folders", bufnr))
                vim.keymap.set("n", "<leader>Lh" , "<cmd> lua vim.lsp.buf.hover()<cr>",default_opts("Hover Documentation", bufnr))
                vim.keymap.set("n", "<leader>Ls" , "<cmd> lua vim.lsp.buf.signature_help()<cr>",default_opts("Signature help", bufnr))
                vim.keymap.set("n", "<leader>r"  , "<cmd> lua vim.lsp.buf.rename()<cr>",default_opts("Rename", bufnr))
                vim.keymap.set("n", "<leader>f"  , "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code", bufnr))
                vim.keymap.set("v", "<leader>f"  , "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code",bufnr))
                vim.keymap.set("n", "<leader>h"  , "<cmd> lua vim.lsp.buf.hover()<cr>",default_opts("Hover Documentation", bufnr))
                vim.keymap.set("n", "<leader>i"  , function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hint" })
              end

              -- Enable formatting
              format_callback = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    if vim.g.formatsave then
                      if client.supports_method("textDocument/formatting") then
                        local params = require'vim.lsp.util'.make_formatting_params({})
                        client.request('textDocument/formatting', params, nil, bufnr)
                      end
                    end
                  end
                })
              end

              default_on_attach = function(client, bufnr)
                attach_keymaps(client, bufnr)
                format_callback(client, bufnr)
              end

              local capabilities = vim.lsp.protocol.make_client_capabilities()

              -- organize imports sync
              vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                  vim.lsp.buf.format()
                  vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
                  vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
                end,
              })

              -- Language Server Configurations
              ${concatMapStringsSep "\n" (cfg: cfg.config) lspConfigs}
            '';
        }
      ]
      ++ extraPlugins;
  };
}
