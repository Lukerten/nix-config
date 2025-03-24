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

                -- Rename
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, default_opts("Rename", bufnr))
                vim.keymap.set("n", "grn", vim.lsp.buf.rename, default_opts("Rename", bufnr))

                -- Code Actions
                vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, default_opts("Code Actions", bufnr))
                vim.keymap.set("n", "gra", vim.lsp.buf.code_action, default_opts("Code Actions", bufnr))

                -- References
                vim.keymap.set("n", "<leader>g", vim.lsp.buf.references, default_opts("References", bufnr))
                vim.keymap.set("n", "grr", vim.lsp.buf.references, default_opts("References", bufnr))

                -- Signature
                vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, default_opts("Signature Help", bufnr))
                vim.keymap.set("n", "grs", vim.lsp.buf.signature_help, default_opts("Signature Help", bufnr))

                -- Hover
                vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, default_opts("Hover", bufnr))
                vim.keymap.set("n", "grh", vim.lsp.buf.hover, default_opts("Hover", bufnr))

                -- Format
                vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, default_opts("Format", bufnr))
                vim.keymap.set("n", "grf", vim.lsp.buf.format, default_opts("Format", bufnr))

                -- GoTo
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, default_opts("Go To Definition", bufnr))
                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, default_opts("Go To Declaration", bufnr))
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, default_opts("Go To Implementation", bufnr))
                vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, default_opts("Go To Type Definition", bufnr))

                -- Inlay Hints
                vim.keymap.set("n", "<leader>i"  , function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hint" })
              end

              default_on_attach = function(client, bufnr)
                attach_keymaps(client, bufnr)
                format_callback(client, bufnr)
              end
              local capabilities = vim.lsp.protocol.make_client_capabilities()

              -- Language Server Configurations
              ${concatMapStringsSep "\n" (cfg: cfg.config) lspConfigs}
            '';
        }
      ]
      ++ extraPlugins;
  };
}
