{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.lua-language-server;
      config = ''
        -- Lua Language Server
        lspconfig.lua_ls.setup{
          capabilities = capabilities;
          on_attach = attach_keymaps,
          cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
          filetypes = { 'lua' },
          root_dir = util.root_pattern('.luarc.json', '.luacheckrc', '.stylua.toml', 'init.lua', '.git'),
          settings = {
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
          },
        }
      '';
    }
  ];
  formatter = {
    package = pkgs.stylua;
    config = ''
      -- Lua formatting: stylua
      table.insert(ls_sources, null_ls.builtins.formatting.stylua.with({
        command = "${pkgs.stylua}/bin/stylua",
      }))
    '';
  };
  extraPackages = [];
  extraPlugins = [];
}
