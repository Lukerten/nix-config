{
  programs.nixvim.plugins = {
    bacon.enable = true;
    conform-nvim.settings.formatters_by_ft.rust = ["rustfmt"];
    luasnip.fromSnipmate = [
      {
        paths = ../snippets/store/snippets/rust.snippets;
        include = ["rust"];
      }
    ];
    # Extra PLugin Rustacean
    rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;
        server = {
          default_settings = {
            inlayHints = {lifetimeElisionHints = {enable = "always";};};
            rust-analyzer = {
              cargo = {allFeatures = true;};
              check = {command = "clippy";};
              files = {excludeDirs = ["target" ".git" ".cargo" ".github" ".direnv"];};
            };
          };
        };
      };
    };
    rustaceanvim.settings.server = {
      dap.adapters.lldb = {
        type = "server";
        port = "${''$''}{port}";
        executable = {
          command = "codelldb";
          args = ["--port" "${''$''}{port}"];
        };
      };
    };
  };
}
