{
  programs.nixvim = {
    plugins.avante = {
      # TODO: set this up!
      enable = true;

      lazyLoad.settings.event = ["BufEnter"];
      settings = {
        mappings = {
          files = {
            add_current = "<leader>a.";
          };
        };
        copilot = {
          model = "claude-3.7-sonnet";
          endpoint = "https://api.githubcopilot.com";
          allow_insecure = false;
          timeout = 10 * 60 * 1000;
          temperature = 0;
          max_completion_tokens = 1000000;
          reasoning_effort = "high";
        };
        diff = {
          autojump = true;
          debug = false;
          list_opener = "copen";
        };
        highlights = {
          diff = {
            current = "DiffText";
            incoming = "DiffAdd";
          };
        };
        hints = {
          enabled = true;
        };
        mappings = {
          diff = {
            both = "cb";
            next = "]x";
            none = "c0";
            ours = "co";
            prev = "[x";
            theirs = "tc";
          };
        };
        provider = "copilot";
        windows = {
          sidebar_header = {
            align = "center";
            rounded = true;
          };
          width = 30;
          wrap = true;
        };
      };
    };

    plugins.render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "markdown"
          "Avante"
        ];
      };
    };
  };
}
