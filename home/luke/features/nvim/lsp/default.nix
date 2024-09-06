{pkgs, ...}: {
  imports = [./lspconfig.nix ./null-ls.nix ./trouble.nix];

  programs.neovim.plugins = [
    pkgs.vimPlugins.lspkind-nvim
    pkgs.vimPlugins.nvim-jdtls
    pkgs.vimPlugins.phpactor
    pkgs.vimPlugins.coc-tailwindcss
    pkgs.vimPlugins.tailwindcss-colors-nvim
    {
      plugin = pkgs.vimPlugins.rust-tools-nvim;
      type = "lua";
      config =
        # lua
        ''
          local rust_tools = require('rust-tools')
          add_lsp(rust_tools, {
            cmd = { "rust-analyzer" },
            tools = { autoSetHints = true }
          })
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
    }
  ];
}
