{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.kommentary;
      type = "lua";
      config =
        # lua
        ''
          require("kommentary.config").configure_language("default", {
            prefer_single_line_comments = true,
            use_consistent_indentation = true,
            ignore_whitespace = true,
          })

          vim.keymap.set("v", "<leader>c", "<Plug>kommentary_visual_default", default_opts("Comment Lines"))
        '';
    }
  ];
}
