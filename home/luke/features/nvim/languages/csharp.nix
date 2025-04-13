{
  pkgs,
  config,
  lib,
  ...
}: let
  hasNeotest = config.programs.nixvim.plugins.neotest.enable;
in {
  programs.nixvim.plugins = {
    lsp.servers.omnisharp = {
      enable = true;
      cmd = [
        "${pkgs.dotnetCorePackages.dotnet_8.sdk}/bin/dotnet"
        "${pkgs.omnisharp-roslyn}/lib/omnisharp-roslyn/OmniSharp.dll"
      ];
    };

    none-ls.sources.formatting.csharpier.enable = true;
    neotest.adapters.dotnet.enable = lib.mkIf hasNeotest true;
    luasnip.fromSnipmate = [
      {
        paths = ../snippets/store/snippets/cs.snippets;
        include = ["cs"];
      }
    ];
    dap = {
      configurations.cs = [
        {
          type = "coreclr";
          request = "launch";
          name = "launch - netcoredbg";
          program = ''
            function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
          '';
        }
      ];
    };
  };
}
