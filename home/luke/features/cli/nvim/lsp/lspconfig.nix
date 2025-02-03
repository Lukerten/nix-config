{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  lspconfigs = [
    # lua
    ''
      -- Bash language server
      lspconfig.bashls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.bash-language-server}/bin/bash-language-server'};
      }
    ''
    # lua
    ''
      -- C/C++ language server
      local function switch_source_header(bufnr)
        bufnr = util.validate_bufnr(bufnr)
        local clangd_client = util.get_active_client_by_name(bufnr, 'clangd')
        local params = { uri = vim.uri_from_bufnr(bufnr) }
        if clangd_client then
          clangd_client.request('textDocument/switchSourceHeader', params, function(err, result)
            if err then
              error(tostring(err))
            end
            if not result then
              print 'Corresponding file cannot be determined'
              return
            end
            vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
          end, bufnr)
        else
          print 'method textDocument/switchSourceHeader is not supported by any servers active on the current buffer'
        end
      end

      local function symbol_info()
        local bufnr = vim.api.nvim_get_current_buf()
        local clangd_client = util.get_active_client_by_name(bufnr, 'clangd')
        if not clangd_client or not clangd_client.supports_method 'textDocument/symbolInfo' then
          return vim.notify('Clangd client not found', vim.log.levels.ERROR)
        end
        local params = vim.lsp.util.make_position_params()
        clangd_client.request('textDocument/symbolInfo', params, function(err, res)
          if err or #res == 0 then
            -- Clangd always returns an error, there is not reason to parse it
            return
          end
          local container = string.format('container: %s', res[1].containerName) ---@type string
          local name = string.format('name: %s', res[1].name) ---@type string
          vim.lsp.util.open_floating_preview({ name, container }, "", {
            height = 2,
            width = math.max(string.len(name), string.len(container)),
            focusable = false,
            focus = false,
            border = require('lspconfig.ui.windows').default_options.border or 'single',
            title = 'Symbol Info',
          })
        end, bufnr)
      end

      local root_files = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
      }

      local clangd_capabilities = {
        textDocument = {
          completion = {
            editsNearCursor = true,
          },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
      }

      lspconfig.clangd.setup{
        cmd = {'${pkgs.clang-tools}/bin/clangd'},
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        root_dir = function(fname)
          return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        single_file_support = true,
        capabilities = default_capabilities,
        on_attach = attach_keymaps,
      }
    ''
    # lua
    ''
      -- CSS language server
      lspconfig.cssls.setup{
        cmd = {'${pkgs.vscode-langservers-extracted}/bin/vscode-css-languageserver-bin', "--stdio"},
        filetypes = {'css', 'scss', 'less'},
        init_options = { provideFormatter = true },
        settings = {
          css = {
            validate = true,
          },
          less = {
            validate = true,
          },
          scss = {
            validate = true,
          },
        },
      }
    ''
    # lua
    ''
      -- Elixir language server
      lspconfig.elixirls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.elixir-ls}/bin/language_server.sh'},
      }
    ''
    # lua
    ''
      -- Erlang language server
      lspconfig.erlangls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.erlang-ls}/bin/erlang_ls'},
      }
    ''
    # lua
    ''
      -- eslint language server
      lspconfig.eslint.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.eslint_d}/bin/eslint_d'};
      }
    ''
    # lua
    ''
      -- Go language server
      lspconfig.gopls.setup{
        on_attach = attach_keymaps,
        cmd = {'${pkgs.gopls}/bin/gopls'},
        filetypes = {'gox', 'go'},
      }
    ''
    # lua
    ''
      -- Haskell language server
      lspconfig.hls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper'},
      }
    ''
    # lua
    ''
      -- HYPR language server hyprls
      lspconfig.hyprls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.hyprls}/bin/hyprls'},
      }
    ''
    # lua
    ''
      local home = os.getenv("HOME")
      local jdtls = require("jdtls")
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
      local root_dir = require("jdtls.setup").find_root(root_markers)

      -- If root_dir is nil, use current working directory
      if root_dir == nil then
        root_dir = vim.fn.getcwd()
      end

      local workspace_folder = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

      -- Setting up root_dir
      local function get_root_dir()
        return lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.expand('%:p:h'))
      end

      local jdtls_config_dir = home .. "/.config/jdtls_config"
      os.execute("mkdir -p " .. jdtls_config_dir)

      -- Copy from nix store to config dir
      os.execute("cp -r ${pkgs.jdt-language-server}/config_linux/* " .. jdtls_config_dir)

      -- Debuging
      local bundles = {}
      local debug_bundles = vim.split(vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/*.jar"), "\n")
      local test_bundles = vim.split(vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar"), "\n")
      vim.list_extend(bundles, debug_bundles)
      -- vim.list_extend(bundles, test_bundles) TODO: Need to look into

      java_on_attach = function(client, bufnr)
        attach_keymaps(client, bufnr)
        local opts = { noremap=true, silent=true, buffer = bufnr }
        vim.keymap.set("n", "<leader>Ljo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
        vim.keymap.set("n", "<leader>Ljrv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
        vim.keymap.set("x", "<leader>Ljrv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
        vim.keymap.set("n", "<leader>Ljrc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
        vim.keymap.set("x", "<leader>Ljrc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
        vim.keymap.set("x", "<leader>Ljrm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)

        -- Set autocommands conditional on server_capabilities
        vim.lsp.codelens.refresh()
      end

      local config = {
        flags = {
          allow_incremental_sync = true,
        };
        capabilities = capabilities,
        on_attach = java_on_attach,
      };

      config.settings = {
        java = {
          referencesCodeLens = {enabled = true},
          signatureHelp = { enabled = true },
          implementationsCodeLens = { enabled = true },
          contentProvider = { preferred = 'fernflower' },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*"
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "${pkgs.jdk17}/lib/openjdk/",
              },
              {
                name = "JavaSE-21",
                path = "${pkgs.jdk21}/lib/openjdk/",
              },
            },
          },
        },
      }
      config.cmd = {
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
      config.root_dir = get_root_dir()
      config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
      end

      local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
      config.init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities;
      };
      config.filetypes = {"java"};
      local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })

      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = { "java" },
          callback = function()
            jdtls.start_or_attach(config)
            jdtls.setup_dap({ hotcodereplace = "auto" })
            -- jdtls.dap.setup_dap_main_class_configs() TODO: return a nil
          end,
          group = nvim_jdtls_group,
        }
      )
    ''
    # lua
    ''
      -- JSON language server
      lspconfig.jsonls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver', '--stdio'},
        root_dir = util.find_git_ancestor,
        single_file_support = true,
        init_options = {
          provideFormatter = true,
        },
        filetypes = { 'json', 'jsonc' },
        docs = {
          -- this language server config is in VSCode built-in package.json
          description = [[
            https://github.com/hrsh7th/vscode-langservers-extracted
            vscode-json-language-server, a language server for JSON and JSON schema

            ```lua
            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require'lspconfig'.jsonls.setup {
              capabilities = capabilities,
            }
            ```
          ]],
        },
      }
    ''
    # lua
    ''
      -- Kotlin language server
      lspconfig.kotlin_language_server.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.kotlin-language-server}/bin/kotlin-language-server'},
      }
    ''
    # lua
    ''
      -- Lua language server
      lspconfig.lua_ls.setup{
        capabilities = capabilities,
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
          },
        },
      }
    ''
    # lua
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
    # lua
    ''
      -- PHP language server
      lspconfig.phpactor.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.phpactor}/bin/phpactor', 'language-server'},
        filetypes = {'php'},
        root_dir = function(pattern)
          local cwd = vim.loop.cwd()
          local root = util.root_pattern('composer.json', '.git', 'phpactor.json', '.git', '.gitignore')(cwd)
          return util.path.is_descendant(cwd, root) and cwd or root
        end,
        docs = {
          description = [[
            https://github.com/phpactor/phpactor
            Installation: https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
          ]],
        },
      }
    ''
    # lua
    ''
      -- Python language server
      local root_files = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
      }

      local function organize_imports()
        local params = {
          command = 'pyright.organizeimports',
          arguments = { vim.uri_from_bufnr(0) },
        }

        local clients = util.get_lsp_clients {
          bufnr = vim.api.nvim_get_current_buf(),
          name = 'pyright',
        }
        for _, client in ipairs(clients) do
          client.request('workspace/executeCommand', params, nil, 0)
        end
      end

      local function set_python_path(path)
        local clients = util.get_lsp_clients {
          bufnr = vim.api.nvim_get_current_buf(),
          name = 'pyright',
        }
        for _, client in ipairs(clients) do
          if client.settings then
            client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
          else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
          end
          client.notify('workspace/didChangeConfiguration', { settings = nil })
        end
      end

      lspconfig.pyright.setup{
        cmd = {"${pkgs.pyright}/bin/pyright-langserver", "--stdio"},
        filetypes = { 'python' },
        root_dir = function(fname)
          return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
        docs = {
          description = [[
            https://github.com/microsoft/pyright

            `pyright`, a static type checker and language server for python
          ]],
        },
        commands = {
          PyrightOrganizeImports = {
            organize_imports,
            description = 'Organize Imports',
          },
          PyrightSetPythonPath = {
            set_python_path,
            description = 'Reconfigure pyright with the provided python path',
            nargs = 1,
            complete = 'file',
          },
        },
        on_new_config = function(config, root_dir)
          local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
          if string.len(env) > 0 then
            config.settings.python.pythonPath = env .. '/bin/python'
          end
        end
      }

      lspconfig.pyright.before_init = function(params, config)
        local Path = require "plenary.path"
        local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
        if venv:joinpath("bin"):is_dir() then
          config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
        else
          config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
        end
      end
    ''
    # lua
    ''
      -- Rust language server
      local function reload_workspace(bufnr)
        bufnr = util.validate_bufnr(bufnr)
        local clients = util.get_lsp_clients { bufnr = bufnr, name = 'rust_analyzer' }
        for _, client in ipairs(clients) do
          vim.notify 'Reloading Cargo Workspace'
          client.request('rust-analyzer/reloadWorkspace', nil, function(err)
            if err then
              error(tostring(err))
            end
            vim.notify 'Cargo workspace reloaded'
          end, 0)
        end
      end

      local function is_library(fname)
        local user_home = util.path.sanitize(vim.env.HOME)
        local cargo_home = os.getenv 'CARGO_HOME' or util.path.join(user_home, '.cargo')
        local registry = util.path.join(cargo_home, 'registry', 'src')
        local git_registry = util.path.join(cargo_home, 'git', 'checkouts')

        local rustup_home = os.getenv 'RUSTUP_HOME' or util.path.join(user_home, '.rustup')
        local toolchains = util.path.join(rustup_home, 'toolchains')

        for _, item in ipairs { toolchains, registry, git_registry } do
          if util.path.is_descendant(item, fname) then
            local clients = util.get_lsp_clients { name = 'rust_analyzer' }
            return #clients > 0 and clients[#clients].config.root_dir or nil
          end
        end
      end

      lspconfig.rust_analyzer.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = {'${pkgs.rust-analyzer}/bin/rust-analyzer'},
        filetypes = { 'rust' },
        single_file_support = true,
        root_dir = function(fname)
          local reuse_active = is_library(fname)
          if reuse_active then
            return reuse_active
          end

          local cargo_crate_dir = util.root_pattern 'Cargo.toml'(fname)
          local cargo_workspace_root

          if cargo_crate_dir ~= nil then
            local cmd = {
              'cargo',
              'metadata',
              '--no-deps',
              '--format-version',
              '1',
              '--manifest-path',
              util.path.join(cargo_crate_dir, 'Cargo.toml'),
            }

            local result = async.run_command(cmd)

            if result and result[1] then
              result = vim.json.decode(table.concat(result, ""))
              if result['workspace_root'] then
                cargo_workspace_root = util.path.sanitize(result['workspace_root'])
              end
            end
          end

          return cargo_workspace_root
            or cargo_crate_dir
            or util.root_pattern 'rust-project.json'(fname)
            or util.find_git_ancestor(fname)
        end,
        before_init = function(init_params, config)
          -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
          if config.settings and config.settings['rust-analyzer'] then
            init_params.initializationOptions = config.settings['rust-analyzer']
          end
        end,
      }
    ''
    # lua
    ''
      -- SQL language server
      local root_dir = require('lspconfig/util').root_pattern('.git', 'flake.nix')(vim.fn.getcwd())
      lspconfig.sqlls.setup {
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.sqls}/bin/sqls", "-config", string.format("%s/config.yml", root_dir) };
        filetypes = { 'sql', 'mysql' },
        root_dir = util.root_pattern 'config.yml',
        single_file_support = true,
      }
    ''
    # lua
    ''
      -- Svelte language server
      lspconfig.svelte.setup{
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = {'${pkgs.svelte-language-server}/bin/svelteserver','--stdio'};
        root_dir = util.root_pattern('package.json', '.git'),
        filetypes = { 'svelte' },
      }
    ''
    # lua
    ''
      -- TailwindCSS language server
      lspconfig.tailwindcss.setup{
        cmd = {'${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server'};
        filetypes = {'css', 'scss', 'less', 'html', 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'};
        root_dir = require('lspconfig/util').root_pattern('tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.lua', 'package.json');
        on_attach = attach_keymaps;
        capabilities = capabilities;
      }
    ''
    # lua
    ''
      -- TerraForm language server
      lspconfig.terraformls.setup {
        capabilities = capabilities,
        on_attach = attach_keymaps,
        cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" },
        filetypes = { 'terraform', 'terraform-vars' },
        root_dir = util.root_pattern('.terraform', '.git'),
      }
    ''
    # lua
    ''
      -- TypeScript language server
      lspconfig.ts_ls.setup {
        capabilities = capabilities;
        on_attach = attach_keymaps,
        cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" }
      }
    ''
    # lua
    ''
      -- YAML language server
      lspconfig.yamlls.setup{
        capabilities = capabilities,
        on_attach = attach_keymaps,
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_dir = util.find_git_ancestor,
        cmd = {'${pkgs.yaml-language-server}/bin/yaml-language-server','--stdio'},
        settings = {
          -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
          redhat = { telemetry = { enabled = false } },
        },
        docs = {
          description = [[
            https://github.com/redhat-developer/yaml-language-server
          ]],
        },
      }
    ''
    # lua
    ''
      -- XML language server
      lspconfig.lemminx.setup{
        capabilities = capabilities;
        on_attach = default_on_attach,
        cmd = { "${pkgs.lemminx}/bin/lemminx" },
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
          local util = require('lspconfig.util')
          local async = require 'lspconfig.async'
          local capabilities = vim.lsp.protocol.make_client_capabilities()
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
            vim.keymap.set("n", "<leader>i", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hint" })
          end

          -- Add all language servers
          ${concatMapStringsSep "\n" (s: s) lspconfigs}
        '';
    }
  ];
}
