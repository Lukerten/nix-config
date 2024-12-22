{pkgs, ...}: let
  dap-config = #lua
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

    vim.keymap.set("n", "<leader>do", dap.repl.open)
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dm", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>dB", function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
    vim.keymap.set("n", "<leader>dp", function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

    vim.keymap.set("n", "<F9>", dap.continue)
    vim.keymap.set("n", "<F10>", dap.step_into)
    vim.keymap.set("n", "<F11>", dap.step_over)
    vim.keymap.set("n", "<F8>", dap.step_out)
    vim.keymap.set("n", "<F7>", dap.restart)
  '';

  dap-ui-config = #lua
  ''
    local dapui = require"dapui"

    dapui.setup()
    vim.keymap.set("n", "<leader>du", dapui.toggle)

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

  dap-virtual-text-config = #lua
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
