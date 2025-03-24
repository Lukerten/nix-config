{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.jdt-language-server;
      config =
        #lua
        ''
          -- Java Language Server
          local home = os.getenv("HOME")
          local jdtls = require('jdtls')
          local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
          local root_dir = jdtls.setup.find_root(root_markers)

          local function get_root_dir()
            return lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.expand('%:p:h'))
          end

          java_on_attach = function(client, bufnr)
            attach_keymaps(client, bufnr)
            local opts = { noremap=true, silent=true, buffer = bufnr }
            vim.keymap.set("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", default_opts("Organize imports", bufnr))
            vim.keymap.set("n", "<leader>jrv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", default_opts("Extract variable", bufnr))
            vim.keymap.set("x", "<leader>jrv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", default_opts("Extract variable", bufnr))
            vim.keymap.set("n", "<leader>jrc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", default_opts("Extract constant", bufnr))
            vim.keymap.set("x", "<leader>jrc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", default_opts("Extract constant", bufnr))
            vim.keymap.set("x", "<leader>jrm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", default_opts("Extract method", bufnr))
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
                vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1),
                vim.fn.glob("${pkgs.lombok}/share/java/lombok/lombok.jar", 1),
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
        '';
    }
  ];
  formatter = {
    package = pkgs.google-java-format;
    config =
      # lua
      ''
        -- Java formatting: google-java-format
          table.insert(ls_sources, none_ls.builtins.formatting.google_java_format.with({
            command = "${pkgs.google-java-format}/bin/google-java-format",
            args = {
              "--aosp",
              "--skip-removing-unused-imports",
            },
          }))
      '';
  };
  extraPackages = [];
  extraPlugins = [];
}
