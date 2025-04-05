{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
      type = "lua";
      config =
        # lua
        ''
            -- Disable Built-in LSP diagnostics
            vim.o.updatetime = 250
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false
              }
              )

            --
            require("tiny-inline-diagnostic").setup({
              preset = "simple",

              hi = {
                error = "DiagnosticError", -- Highlight group for error messages
                warn = "DiagnosticWarn", -- Highlight group for warning messages
                info = "DiagnosticInfo", -- Highlight group for informational messages
                hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
                arrow = "NonText", -- Highlight group for diagnostic arrows
                background = "CursorLine",
                mixing_color = "None",
              },

              options = {
                show_source = false,
                use_icons_from_diagnostic = false,
                set_arrow_to_diag_color = false,
                add_messages = true,
                throttle = 20,
                softwrap = 30,

                multilines = {
                  enabled = true,
                  always_show = true,
                },

                show_all_diags_on_cursorline = false,
                enable_on_insert = false,
                enable_on_select = true,

                overflow = {
                  mode = "wrap",
                  padding = 2,
                },

                break_line = {
                  enabled = false,
                  after = 30,
                },
              },
              disabled_ft = {}
          })
        '';
    }
  ];
}
