{pkgs, ...}: let
  kommentary-nvim = pkgs.vimPlugins.kommentary;

  kommentary-config =
    # lua
    ''
      require("kommentary.config").configure_language("default", {
        prefer_single_line_comments = true,
        use_consistent_indentation = true,
        ignore_whitespace = true,
      })

      vim.keymap.set("n", "<space>c", "<Plug>kommentary_line_default", {})
      vim.keymap.set("v", "<space>c", "<Plug>kommentary_visual_default", {})
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = kommentary-nvim;
      type = "lua";
      config = kommentary-config;
    }
  ];
}
