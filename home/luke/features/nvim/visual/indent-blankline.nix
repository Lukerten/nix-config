{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "▏";
      };
      whitespace.remove_blankline_trail = false;
      scope = {
        show_start = false;
        show_end = false;
        show_exact_scope = true;
      };
      exclude = {
        filetypes = [
          ""
          "checkhealth"
          "help"
          "lspinfo"
          "packer"
          "TelescopePrompt"
          "TelescopeResults"
          "yaml"
        ];
        buftypes = [
          "terminal"
          "quickfix"
        ];
      };
    };
  };
}
