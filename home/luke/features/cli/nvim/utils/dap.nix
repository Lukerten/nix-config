{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  languages = import ../languages {inherit pkgs lib;};
  dapConfigs = languages.dapConfigs;
  dapPackages = languages.dapPackages;
in {
  programs.neovim.plugins =
    dapPackages
    ++ [
      {
        plugin = pkgs.vimPlugins.nvim-dap-virtual-text;
        type = "lua";
        config =
          #lua
          ''
            require("nvim-dap-virtual-text").setup()
          '';
      }
      {
        plugin = pkgs.vimPlugins.nvim-dap;
        type = "lua";
        config =
          #lua
          ''
            local dap = require('dap')

            -- Configurations

            ${concatMapStringsSep "\n" (cfg: cfg) dapConfigs}
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
      }
      {
        plugin = pkgs.vimPlugins.nvim-dap-ui;
        type = "lua";
        config =
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
      }
    ];
}
