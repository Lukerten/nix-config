{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      copilot-lua.enable = true;
      avante = {
        enable = true;

        lazyLoad.settings.event = ["BufEnter"];
        settings = {
          mappings = {
            files = {
              add_current = "<leader>ac";
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
          hints.enabled = true;
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
              align = "right";
              rounded = false;
            };
            width = 30;
            wrap = true;
          };
        };
      };

      render-markdown = {
        enable = true;
        lazyLoad.settings = {
          ft = ["Avante"];
        };
        settings = {
          file_types = [
            "Avante"
          ];
        };
      };
    };

    extraPackages = with pkgs; [nodejs-slim];
  };
}
