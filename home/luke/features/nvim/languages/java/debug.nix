{
  programs.nixvim.plugins = {
    dap = {
      adapters.servers.java = {
        host = "127.0.0.1";
        port = 5006;
        id = "2";
        executable.command = ''
          config = function()
               require("java").setup {}
               require("lspconfig").jdtls.setup {
                 on_attach = require("plugins.configs.lspconfig").on_attach,
                 capabilities = require("plugins.configs.lspconfig").capabilities,
                 filetypes = { "java" },
               }
             end,
        '';
      };

      configurations.java = [
        {
          type = "java";
          request = "launch";
          #request = "attach";
          name = "Debug (Attach) - Remote";
          hostName = "127.0.0.1";
          port = 5005;
        }
      ];
    };
  };
}
