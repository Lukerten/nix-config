{pkgs, ...}: let
  dap-config =
    #lua
    ''
      local dap = require('dap')

      -- JAVA
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 8000,
        },
      }

      -- Scala DAP configurations
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run or Test Target",
          metals = {
            runType = "runOrTestFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }

      vim.keymap.set("n", "<leader>Do", dap.repl.open, default_opts("Open REPL"))
      vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, default_opts("Toggle Breakpoint"))
      vim.keymap.set("n", "<leader>Dm", dap.run_to_cursor, default_opts("Run to Cursor"))
      vim.keymap.set("n", "<leader>DB", function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, default_opts("Set Breakpoint"))
      vim.keymap.set("n", "<leader>Dp", function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, default_opts("Log Point"))
      vim.keymap.set("n", "<F9>", dap.continue, default_opts("Continue"))
      vim.keymap.set("n", "<F10>", dap.step_into, default_opts("Step Into"))
      vim.keymap.set("n", "<F11>", dap.step_over, default_opts("Step Over"))
      vim.keymap.set("n", "<F8>", dap.step_out, default_opts("Step Out"))
      vim.keymap.set("n", "<F7>", dap.restart, default_opts("Restart"))
    '';

  dap-ui-config =
    #lua
    ''
      local dapui = require"dapui"

      dapui.setup()
      vim.keymap.set("n", "<leader>Du", dapui.toggle)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    '';

  dap-virtual-text-config =
    #lua
    ''
      require("nvim-dap-virtual-text").setup()
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.nvim-dap-virtual-text;
      type = "lua";
      config = dap-virtual-text-config;
    }
    {
      plugin = pkgs.vimPlugins.nvim-dap;
      type = "lua";
      config = dap-config;
    }
    {
      plugin = pkgs.vimPlugins.nvim-dap-ui;
      type = "lua";
      config = dap-ui-config;
    }
  ];
}
