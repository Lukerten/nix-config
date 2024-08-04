{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  lspconfigs = [
    ''
      -- Bash language server
      lspconfig.bashls.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
       cmd = {'${pkgs.bash-language-server}/bin/bash-language-server'};
      }
    ''
    ''
      -- C/C++ language server
      local clangd_capabilities = capabilities;
      clangd_capabilities.textDocument.semanticHighlighting = true;
      clangd_capabilities.offsetEncoding = {"utf-8"};
      lspconfig.clangd.setup{
        capabilities = clangd_capabilities,
        on_attach = attach_keymaps,
        cmd = {"${pkgs.clang-tools}/bin/clangd"};
      }
    ''
    ''
      -- CSS language server
      lspconfig.cssls.setup{
        cmd = {'${pkgs.gopls}/bin/vscode-css-languageserver-bin'};
        filetypes = {'css', 'scss', 'less'};
        settings = {
          css = {
            validate = true;
          };
          less = {
            validate = true;
          };
          scss = {
            validate = true;
          };
        };
      }
    ''
    ''
      -- Go language server
      lspconfig.gopls.setup{
        on_attach = attach_keymaps,
        cmd = {'${pkgs.gopls}/bin/gopls'};
        filetypes = {'gox', 'go'};
      }
    ''
    ''
      -- Haskell language server
      lspconfig.hls.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper'};
      }
    ''
    ''
      -- Java language server
      -- workspace setup
      local home = os.getenv("HOME")
      local jdtls = require('jdtls')
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
      local root_dir = jdtls.setup.find_root(root_markers)

      -- Function to set root_dir to the parent directory of the .git folder
      local function get_root_dir()
        return lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.expand('%:p:h'))
      end

      java_on_attach = function(client, bufnr)
        attach_keymaps(client, bufnr)
        local opts = { noremap=true, silent=true, buffer = bufnr }
          vim.keymap.set("n", "<space>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", default_opts("Organize imports", bufnr))
          vim.keymap.set("n", "<space>jrv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", default_opts("Extract variable", bufnr))
          vim.keymap.set("x", "<space>jrv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", default_opts("Extract variable", bufnr))
          vim.keymap.set("n", "<space>jrc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", default_opts("Extract constant", bufnr))
          vim.keymap.set("x", "<space>jrc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", default_opts("Extract constant", bufnr))
          vim.keymap.set("x", "<space>jrm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", default_opts("Extract method", bufnr))
          vim.lsp.codelens.refresh()
      end

      local workspace_folder = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
      local jdtls_config_dir = home .. "/.config/jdtls_config"
      os.execute("mkdir -p " .. jdtls_config_dir)

      -- Copy from nix store to config dir
      os.execute("cp -r ${pkgs.jdt-language-server}/config_linux/* " .. jdtls_config_dir)

      lspconfig.jdtls.setup{
        capabilities = capabilities;
        on_attach = java_on_attach,
        cmd = {
          "${pkgs.jdt-language-server}/bin/jdtls",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Dosgi.sharedConfiguration.area=${pkgs.jdt-language-server}/share/config",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          "-configuration", jdtls_config_dir,
          "-data", workspace_folder,
        };
        root_dir = get_root_dir;
        init_options = {
          bundles = {
            vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar", 1),
            vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1)
          };
        };
        settings = {
          java = {
            referencesCodeLens = {enabled = true};
            signatureHelp = { enabled = true };
            implementationsCodeLens = { enabled = true };
            contentProvider = { preferred = 'fernflower' };
          },
        };
        handlers = {
          ["language/status"] = function(_, result)
            if result.value == "error" then
              vim.lsp.diagnostic.set_loclist({open_loclist = false})
            end
          end
        };
        filetypes = { "java" };
      }
    ''
    ''
      -- JSON language server
      lspconfig.jsonls.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver'};
      }
    ''
    ''
      -- Kotlin language server
      lspconfig.kotlin_language_server.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.kotlin-language-server}/bin/kotlin-language-server'};
      }
    ''
    ''
      -- Lua language server
      lspconfig.lua_ls.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("lua", true),
          },
          telemetry = {
            enable = false,
          };
        };
      }
    ''
    ''
      -- Nix language server
      lspconfig.nil_ls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {"${pkgs.nil}/bin/nil"},
        settings = {
          formatting = {
            command = {"${pkgs.alejandra}/bin/alejandra", "--quiet"},
          },
        },
      }
    ''
    ''
      -- Python language server
      lspconfig.pyright.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.pyright}/bin/pyright-langserver'};
      }
    ''
    ''
      -- Rust language server
      lspconfig.rust_analyzer.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.rust-analyzer}/bin/rust-analyzer'};
      }
    ''
    ''
      -- SQL language server
      local root_dir = require('lspconfig/util').root_pattern('.git', 'flake.nix')(vim.fn.getcwd())
      lspconfig.sqlls.setup {
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.sqls}/bin/sqls", "-config", string.format("%s/config.yml", root_dir) };
        root_dir = function(fname)
          return root_dir
        end;
      }
    ''
    ''
      -- TailwindCSS language server
      lspconfig.tailwindcss.setup{
        cmd = {'${
        pkgs.nodePackages."@tailwindcss/language-server"
      }/bin/tailwindcss-language-server'};
        filetypes = {'css', 'scss', 'less', 'html', 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'};
        root_dir = require('lspconfig/util').root_pattern('tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.lua', 'package.json');
        on_attach = attach_keymaps;
        capabilities = capabilities;
      }
    ''
    ''
      -- TypeScript language server
      lspconfig.tsserver.setup {
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" }
      }
    ''
    ''
      -- Vue language server
      lspconfig.vuels.setup {
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.nodePackages.vls}/bin/vls", "--stdio" }
      }
    ''
    ''
      -- YAML language server
      lspconfig.yamlls.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.yaml-language-server}/bin/yaml-language-server'};
      }
    ''
  ];
in {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.nvim-lspconfig;
      type = "lua";
      config =
        # lua
        ''
          local lspconfig = require('lspconfig')
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          local attach_keymaps = function(client, bufnr)
            local opts = { noremap=true, silent=true }
            -- Keymaps
              vim.keymap.set("n", "<space>Lgc", "<cmd> lua vim.lsp.buf.declaration()<cr>",default_opts("Go to declaration", bufnr))
              vim.keymap.set("n", "<space>Lgd", "<cmd> lua vim.lsp.buf.definition()<cr>",default_opts("Go to definition", bufnr))
              vim.keymap.set("n", "<space>Lgt", "<cmd> lua vim.lsp.buf.type_definition()<cr>",default_opts("Go to type definition", bufnr))
              vim.keymap.set("n", "<space>Lgr", "<cmd> lua vim.lsp.buf.references()<cr>",default_opts("Go to references", bufnr))
              vim.keymap.set("n", "<space>Lgn", "<cmd> lua vim.lsp.diagnostic.goto_next()<cr>",default_opts("next diagnostic", bufnr))
              vim.keymap.set("n", "<space>Lgp", "<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>",default_opts("previous diagnostic", bufnr))
              vim.keymap.set("n", "<space>Lgi", "<cmd> lua vim.lsp.buf.implementation()<cr>",default_opts("Go to implementation", bufnr))
              vim.keymap.set("n", "<space>Lwa", "<cmd> lua vim.lsp.buf.add_workspace_folder()<cr>",default_opts("Add workspace folder", bufnr))
              vim.keymap.set("n", "<space>Lwr", "<cmd> lua vim.lsp.buf.remove_workspace_folder()<cr>",default_opts("Remove workspace folder", bufnr))
              vim.keymap.set("n", "<space>Lwl", "<cmd> lua vim.lsp.buf.list_workspace_folders()<cr>",default_opts("List workspace folders", bufnr))
              vim.keymap.set("n", "<space>Lh" , "<cmd> lua vim.lsp.buf.hover()<cr>",default_opts("Hover Documentation", bufnr))
              vim.keymap.set("n", "<space>Ls" , "<cmd> lua vim.lsp.buf.signature_help()<cr>",default_opts("Signature help", bufnr))
              vim.keymap.set("n", "<space>r"  , "<cmd> lua vim.lsp.buf.rename()<cr>",default_opts("Rename", bufnr))
              vim.keymap.set("n", "<space>f"  , "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code", bufnr))
              vim.keymap.set("v", "<space>f"  , "<cmd> lua vim.lsp.buf.format()<cr>",default_opts("Format code",bufnr))
          end


          -- Add language server with default options
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

          -- Add all language servers
          ${concatMapStringsSep "\n" (s: s) lspconfigs}
        '';
    }
  ];
}
