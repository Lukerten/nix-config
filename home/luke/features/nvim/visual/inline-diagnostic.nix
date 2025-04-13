{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      tiny-inline-diagnostic-nvim
    ];

    diagnostics.virtual_text = false;
    extraConfigLua =
      # lua
      ''
        require("tiny-inline-diagnostic").setup({
          preset = "simple",
          transparent_bg = false,
          transparent_cursorline = false,

          hi = {
            error = "DiagnosticError",
            warn = "DiagnosticWarn",
            virt_textsinfo = "DiagnosticInfo",
            hint = "DiagnosticHint",
            arrow = "NonText",
            background = "CursorLine",
            mixing_color = "None",
          },
          disabled_ft = {},

          options = {
            show_source = {
                enabled = true,
                if_many = true,
            },

            use_icons_from_diagnostic = true,
            set_arrow_to_diag_color = false,
            add_messages = true,
            throttle = 20,
            softwrap = 30,
            multilines = {
                enabled = true,
                always_show = true,
            },
            show_all_diags_on_cursorline = true,
            enable_on_insert = true,
            enable_on_select = true,
            overflow = {
                mode = "wrap",
                padding = 0,
            },
            break_line = {
                enabled = false,
                after = 30,
            },
            format = nil,
            virt_texts = {
                priority = 2048,
            },
            severity = {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
                vim.diagnostic.severity.INFO,
                vim.diagnostic.severity.HINT,
            },
            overwrite_events = nil
          },
        })
      '';
  };
}
