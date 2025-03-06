{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.rust-analyzer;
      config = ''
        -- Rust Tools
        local rt = require('rust-tools')

        rust_on_attach = function(client, bufnr)
          default_on_attach(client, bufnr)
          local opts = { noremap=true, silent=true, buffer = bufnr }
          vim.keymap.set("n", "<leader>ris", rt.inlay_hints.set, opts)
          vim.keymap.set("n", "<leader>riu", rt.inlay_hints.unset, opts)
          vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
          vim.keymap.set("n", "<leader>rp", rt.parent_module.parent_module, opts)
          vim.keymap.set("n", "<leader>rm", rt.expand_macro.expand_macro, opts)
          vim.keymap.set("n", "<leader>rc", rt.open_cargo_toml.open_cargo_toml, opts)
          vim.keymap.set("n", "<leader>rg", function() rt.crate_graph.view_crate_graph("x11", nil) end, opts)
        end

        local rustopts = {
          tools = {
            autoSetHints = true,
            hover_with_actions = false,
            inlay_hints = {
              only_current_line = false,
            }
          },
          server = {
            capabilities = capabilities,
            on_attach = rust_on_attach,
            cmd = {"${pkgs.rust-analyzer}/bin/rust-analyzer"},
            settings = {}
          }
        }

        rt.setup(rustopts)
      '';
    }
  ];
  formatter = {
    package = pkgs.rustfmt;
    config = ''
      table.insert(ls_sources, null_ls.builtins.formatting.rustfmt.with({
           command = "${pkgs.rustfmt}/bin/rustfmt";
         })
       )
    '';
  };
  extraPackages = [];
  extraPlugins = [
    pkgs.vimPlugins.rust-tools-nvim
  ];
}
