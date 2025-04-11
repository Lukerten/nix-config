{
  programs.nixvim.plugins = {
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
