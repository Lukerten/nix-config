{pkgs, ...}: let
  dap-config =
    # lua
    ''
      local dap = require('dap')

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 8000,
        },
      }
      function set_dap_breakpoint()
        require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end

      function set_dap_logpoint()
        require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end

      vim.keymap.set("n", "<space>Do", "dap.repl.open()", default_opts("Open REPL"))
      vim.keymap.set("n", "<space>Dc", dap.continue, default_opts("Continue"))
      vim.keymap.set("n", "<space>Dsn", dap.step_over, default_opts("Step over"))
      vim.keymap.set("n", "<space>Dsi", dap.step_into, default_opts("Step into"))
      vim.keymap.set("n", "<space>Dso", dap.step_out, default_opts("Step out"))
      vim.keymap.set("n", "<space>Dbt", dap.toggle_breakpoint, default_opts("Toggle breakpoint"))
      vim.keymap.set("n", "<space>Dbs", dap.set_breakpoint, default_opts("Set breakpoint"))
      vim.keymap.set("n", "<space>Dbl", set_dap_breakpoint, default_opts("Set breakpoint with condition"))
      vim.keymap.set("n", "<space>Dbl", set_dap_logpoint, default_opts("Set logpoint"))
    '';

  dapui-config =
    # lua
    ''
      local dapui = require('dapui')

      dapui.setup()
      vim.keymap.set("n", "<space>Dt", dapui.toggle, default_opts("Toggle DAP UI"))

      -- Auto Open
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    '';
in {
  programs.neovim.plugins = [
    pkgs.vimPlugins.nvim-dap-virtual-text
    pkgs.vimPlugins.nvim-dap-go
    {
      plugin = pkgs.vimPlugins.nvim-dap;
      type = "lua";
      config = dap-config;
    }
    {
      plugin = pkgs.vimPlugins.nvim-dap-ui;
      type = "lua";
      config = dapui-config;
    }
  ];
}
