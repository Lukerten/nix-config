{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  configuration = [
    {
      package = pkgs.bash-language-server;
      config =
        # lua
        ''
          -- Bash Language Server
          lspconfig.bashls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.bash-language-server}/bin/bash-language-server'};
          }
        '';
    }
    {
      package = pkgs.biome;
      config =
        # lua
        ''
          -- Biome Language Server
          lspconfig.biome.setup{
            cmd = { '${pkgs.biome}/bin/biome', 'lsp-proxy' },
            filetypes = {
              'astro',
              'css',
              'graphql',
              'javascript',
              'javascriptreact',
              'json',
              'jsonc',
              'svelte',
              'typescript',
              'typescript.tsx',
              'typescriptreact',
              'vue',
            },
            on_attach = attach_keymaps,
            root_dir = util.root_pattern('biome.json', 'biome.jsonc'),
            single_file_support = false,
          }
        '';
    }
    {
      package = pkgs.clang-tools;
      config =
        #lua
        ''
          -- Clangd Language Server
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
        '';
    }
    {
      package = pkgs.vscode-langservers-extracted;
      config =
        # lua
        ''
          -- CSS Language Server
          lspconfig.cssls.setup{
            on_attach = attach_keymaps,
            cmd = {'${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server'};
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

          -- HTML Language Server
          lspconfig.html.setup{
            cmd = { '${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server', '--stdio' },
            filetypes = { 'html', 'templ' },
            on_attach = attach_keymaps,
            root_dir = util.root_pattern('package.json', '.git'),
            single_file_support = true,
            settings = {},
            init_options = {
              provideFormatter = true,
              embeddedLanguages = { css = true, javascript = true },
              configurationSection = { 'html', 'css', 'javascript' },
            },
          }
        '';
    }
    {
      package = pkgs.dart;
      config =
        # lua
        ''
          -- Dart Language Server
          lspconfig.dartls.setup{
            cmd = { '${pkgs.dart}/bin/dart', 'language-server', '--protocol=lsp' },
            filetypes = { 'dart' },
            on_attach = attach_keymaps,
            init_options = {
              onlyAnalyzeProjectsWithOpenFiles = true,
              suggestFromUnimportedLibraries = true,
              closingLabels = true,
              outline = true,
              flutterOutline = true,
            },
            settings = {
              dart = {
                completeFunctionCalls = true,
                showTodos = true,
              },
            },
          }
        '';
    }
    {
      package = pkgs.docker-compose-language-service;
      config =
        # lua
        ''
          -- Docker Compose Language Server
          lspconfig.docker_compose_language_service.setup{
            cmd = { '${pkgs.docker-compose-language-service}/bin/docker-compose-langserver', '--stdio' },
            filetypes = { 'yaml.docker-compose' },
            root_dir = util.root_pattern 'docker-compose.yml',
            single_file_support = true,
            on_attach = attach_keymaps,
          }
        '';
    }
    {
      package = pkgs.dockerfile-language-server-nodejs;
      config =
        # lua
        ''
          -- Dockerfile Language Server
          lspconfig.dockerls.setup{
            cmd = { '${pkgs.dockerfile-language-server-nodejs}/bin/docker-langserver', '--stdio' },
            filetypes = { 'dockerfile' },
            root_dir = util.root_pattern 'Dockerfile',
            single_file_support = true,
            on_attach = attach_keymaps,
          }
        '';
    }
    {
      package = pkgs.elixir-ls;
      config =
        # lua
        ''
          lspconfig.elixirls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.elixir-ls}/bin/language_server.sh'};
          }
        '';
    }
    {
      package = pkgs.erlang-ls;
      config =
        # lua
        ''
          -- Erlang language server
          lspconfig.erlangls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.erlang-ls}/bin/erlang_ls'};
          }
        '';
    }
    {
      package = pkgs.eslint_d;
      config =
        # lua
        ''
          -- eslint language server
          lspconfig.eslint.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.eslint_d}/bin/eslint_d'};
          }
        '';
    }
    {
      package = pkgs.golangci-lint-langserver;
      config =
        # lua
        ''
          -- Golangci-lint language server
          lspconfig.golangci_lint_ls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver'};
            filetypes = { 'go', 'gomod' },
            init_options = {
              command = { '${pkgs.golangci-lint}/bin/golangci-lint', 'run', '--out-format', 'json' },
            },
            root_dir = function(fname)
              return util.root_pattern(
                '.golangci.yml',
                '.golangci.yaml',
                '.golangci.toml',
                '.golangci.json',
                'go.work',
                'go.mod',
                '.git'
              )(fname)
            end,
          }
        '';
    }
    {
      package = pkgs.gopls;
      config =
        # lua
        ''
          lspconfig.gopls.setup{
            on_attach = attach_keymaps,
            cmd = {'${pkgs.gopls}/bin/gopls'};
            filetypes = {'gox', 'go'};
          }
        '';
    }
    {
      package = pkgs.haskell-language-server;
      config =
        # lua
        ''
          -- Haskell language server
          lspconfig.hls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper'};
          }
        '';
    }
    {
      package = pkgs.hyprls;
      config =
        # lua
        ''
          -- HYPR language server hyprls
          lspconfig.hyprls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.hyprls}/bin/hyprls'};
          }
        '';
    }
    {
      package = pkgs.jdt-language-server;
      config =
        #lua
        ''
          -- Java language server
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
              "-Dlog.protocol=true",cmd = { 'texlab' },
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
    {
      package = pkgs.nodePackages.vscode-json-languageserver;
      config =
        # lua
        ''
          -- JSON language server
          lspconfig.jsonls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver', '--stdio'};
            root_dir = util.find_git_ancestor,
            single_file_support = true,
            init_options = {
              provideFormatter = true,
            },
            filetypes = { 'json', 'jsonc' },
          }
        '';
    }

    {
      package = pkgs.kotlin-language-server;
      config =
        # lua
        ''
          -- Kotlin language server
          lspconfig.kotlin_language_server.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.kotlin-language-server}/bin/kotlin-language-server'};
          }
        '';
    }
    {
      package = pkgs.lua-language-server;
      config =
        # lua
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
        '';
    }
    {
      package = pkgs.marksman;
      config =
        # lua
        ''
          -- Marksman language server
          lspconfig.marksman.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.marksman}/bin/marksman', 'server'};
          }
        '';
    }
    {
      package = pkgs.nil;
      config =
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
        '';
    }
    {
      package = pkgs.nixd;
      config =
        # lua
        ''
          -- Nix language server
          lspconfig.nixd.setup{
            capabilities = capabilities,
            on_attach = attach_keymaps,
            cmd = {"${pkgs.nixd}/bin/nixd"},
          }
        '';
    }
    {
      package = pkgs.phpactor;
      config =
        # lua
        ''
          -- PHP language server
          lspconfig.phpactor.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.phpactor}/bin/phpactor', 'language-server'};
            filetypes = {'php'};
            root_dir = function(pattern)
              local cwd = vim.loop.cwd()
              local root = util.root_pattern('composer.json', '.git', 'phpactor.json', '.git', '.gitignore')(cwd)
              return util.path.is_descendant(cwd, root) and cwd or root
            end;
          }
        '';
    }
    {
      package = pkgs.ruff;
      config =
        # lua
        ''
          -- Python language server
          lspconfig.pylsp.setup{
            cmd = { '${pkgs.python312Packages.python-lsp-server}/bin/pylsp' },
            filetypes = { 'python' },
            root_dir = function(fname)
              local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
              }
              return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
            end,
            single_file_support = true,
            settings = {
              pylsp = {
                plugins = {
                  ruff = {
                    severities = { ["F401"] = "W" }
                  }
                },
              },
              capabilities = {
                experimental = {
                  inlayHintProvider = true,
                }
              },
            },
          }
        '';
    }
    {
      package = pkgs.rust-analyzer;
      config =
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
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.rust-analyzer}/bin/rust-analyzer'};
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
        '';
    }
    {
      package = pkgs.sqls;
      config =
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
        '';
    }
    {
      package = pkgs.svelte-language-server;
      config =
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
        '';
    }
    {
      package = pkgs.tailwindcss-language-server;
      config =
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
        '';
    }
    {
      package = pkgs.terraform-ls;
      config =
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
        '';
    }
    {
      package = pkgs.taplo;
      config =
        # lua
        ''
          -- Taplo language server
          lspconfig.taplo.setup{
            cmd = {'${pkgs.taplo}/bin/taplo', 'lsp', 'stdio'};
            filetypes = {'toml'};
            root_dir = util.root_pattern('taplo.toml');
            on_attach = attach_keymaps;
            capabilities = capabilities;
          }
        '';
    }
    {
      package = pkgs.texlab;
      config =
        # lua
        ''
          -- TeX language server
          lspconfig.texlab.setup{
            cmd = { '${pkgs.texlab}/bin/texlab' },
            filetypes = { 'tex', 'plaintex', 'bib' },
            root_dir = util.root_pattern('.git', '.latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml'),
            single_file_support = true,
            settings = {
              texlab = {
                rootDirectory = nil,
                build = {
                  executable = 'latexmk',
                  args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                  onSave = false,
                  forwardSearchAfter = false,
                },
                forwardSearch = {
                  executable = nil,
                  args = {},
                },
                chktex = {
                  onOpenAndSave = false,
                  onEdit = false,
                },
                diagnosticsDelay = 300,
                latexFormatter = 'latexindent',
                latexindent = {
                  ['local'] = nil, -- local is a reserved keyword
                  modifyLineBreaks = false,
                },
                bibtexFormatter = 'texlab',
                formatterLineLength = 80,
              },
            },
          }
        '';
    }
    {
      package = pkgs.nodePackages.typescript-language-server;
      config =
        # lua
        ''
          -- TypeScript language server
          lspconfig.ts_ls.setup {
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" }
          }
        '';
    }
    {
      package = pkgs.yaml-language-server;
      config =
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
          }
        '';
    }
  ];

  extraPackages = [
    pkgs.go
    pkgs.nodejs
    pkgs.python3
  ];
in {
  programs.neovim = {
    extraPackages = map (cfg: cfg.package) configuration ++ extraPackages;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
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

          -- Language Server Configurations
          ${lib.concatMapStringsSep "\n" (cfg: cfg.config) configuration}
        '';
      }
    ];
  };
}
