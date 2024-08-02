{ pkgs, ... }:
let
  lspconfig = pkgs.vimPlugins.nvim-lspconfig;
  lsp_config = # lua
    ''
      local lspconfig = require('lspconfig')
      -- Macro to attach LSP servers to the buffer

      function add_lsp(server, options)
        if not options["cmd"] then
          options["cmd"] = server["document_config"]["default_config"]["cmd"]
        end
        if not options["capabilities"] then
          options["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
        end

        if vim.fn.executable(options["cmd"][1]) == 1 then
          server.setup(options)
        end
      end

      -- Setup LSP servers
      add_lsp(lspconfig.bashls, {})
      add_lsp(lspconfig.clangd, {})
      add_lsp(lspconfig.gopls, {})
      add_lsp(lspconfig.hls, {})
      add_lsp(lspconfig.jdtls, {})
      add_lsp(lspconfig.kotlin_language_server, {})
      add_lsp(lspconfig.lua_ls, {})
      add_lsp(lspconfig.nixd, {
        settings = {
          nixd = {
            formatting = {
              command = { "nixfmt" }
            }
          }
        }
      })
      add_lsp(lspconfig.phpactor, {})
      add_lsp(lspconfig.pylsp, {})
      add_lsp(lspconfig.sqlls, {})
      add_lsp(lspconfig.solargraph, {})
      add_lsp(lspconfig.tailwindcss, {})
      add_lsp(lspconfig.terraformls, {})
      add_lsp(lspconfig.tsserver, {})
      add_lsp(lspconfig.vuels, {})
      add_lsp(lspconfig.yamlls, {})
      add_lsp(lspconfig.elixirls, {cmd = {"elixir-ls"}})
      add_lsp(lspconfig.texlab, { chktex = {
        onEdit = true,
        onOpenAndSave = true
      }})

      vim.keymap.set("n", "<space>Lgc", "<cmd> lua vim.lsp.buf.declaration()<cr>",default_opts("Go to declaration"))
      vim.keymap.set("n", "<space>Lgd", "<cmd> lua vim.lsp.buf.definition()<cr>",default_opts("Go to definition"))
      vim.keymap.set("n", "<space>Lgt", "<cmd> lua vim.lsp.buf.type_definition()<cr>",default_opts("Go to type definition"))
      vim.keymap.set("n", "<space>Lgr", "<cmd> lua vim.lsp.buf.references()<cr>",default_opts("Go to references"))
      vim.keymap.set("n", "<space>Lgn", "<cmd> lua vim.lsp.diagnostic.goto_next()<cr>",default_opts("next diagnostic"))
      vim.keymap.set("n", "<space>Lgp", "<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>",default_opts("previous diagnostic"))
      vim.keymap.set("n", "<space>Lgi", "<cmd> lua vim.lsp.buf.implementation()<cr>",default_opts("Go to implementation"))
      vim.keymap.set("n", "<space>Lwa", "<cmd> lua vim.lsp.buf.add_workspace_folder()<cr>",default_opts("Add workspace folder"))
      vim.keymap.set("n", "<space>Lwr", "<cmd> lua vim.lsp.buf.remove_workspace_folder()<cr>",default_opts("Remove workspace folder"))
      vim.keymap.set("n", "<space>Lwl", "<cmd> lua vim.lsp.buf.list_workspace_folders()<cr>",default_opts("List workspace folders"))
      vim.keymap.set("n", "<space>Lh", "<cmd> lua vim.lsp.buf.hover()<cr>",default_opts("Hover Documentation"))
      vim.keymap.set("n", "<space>Ls", "<cmd> lua vim.lsp.buf.signature_help()<cr>",default_opts("Signature help"))
      vim.keymap.set("n", "<space>r", "<cmd> lua vim.lsp.buf.rename()<cr>",default_opts("Rename"))
      vim.keymap.set("n", "<space>f", "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code"))
      vim.keymap.set("v", "<space>f", "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code"))
    '';

  lsp-server-list = with pkgs; [
    bash-language-server
    clang-tools
    dhall-lsp-server
    gopls
    haskell-language-server
    jdt-language-server
    kotlin-language-server
    lua-language-server
    phpactor
    sqls
    tailwindcss-language-server
    terraform-ls
    typescript-language-server
    vue-language-server
    yaml-language-server
    elixir-ls
  ];
in {
  imports = [
    ./fidget.nix
    ./null-ls.nix
  ];

  programs.neovim.plugins = [
    pkgs.vimPlugins.lspkind-nvim
    {
      plugin = lspconfig;
      type = "lua";
      config = lsp_config;
    }
    {
      plugin = pkgs.vimPlugins.ltex_extra-nvim;
      type = "lua";
      config =
        # lua
        ''
          local ltex_extra = require('ltex_extra')
          add_lsp(lspconfig.ltex, {
            on_attach = function(client, bufnr)
              ltex_extra.setup{
                path = vim.fn.expand("~") .. "/.local/state/ltex"
              }
            end
          })
        '';
    }
    {
      plugin = pkgs.vimPlugins.rust-tools-nvim;
      type = "lua";
      config =
        # lua
        ''
          local rust_tools = require('rust-tools')
          add_lsp(rust_tools, {
            cmd = { "rust-analyzer" },
            tools = { autoSetHints = true }
          })
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
    }
  ];
  home.packages = lsp-server-list;
}
