{
  programs.nixvim.plugins = {
    blink-copilot.enable = true;
    blink-emoji.enable = true;
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;

      settings = {
        keymap = {
          preset = "none";
          "<Tab>" = ["snippet_forward" "select_next" "fallback"];
          "<C-Tab>" = ["snippet_backward" "select_next" "fallback"];
          "<C-s>" = ["show_signature" "fallback"];
          "<C-e>" = ["cancel"];
          "<C-Space>" = ["show_documentation" "fallback"];
          "<Up>" = ["scroll_documentation_up" "fallback"];
          "<Down>" = ["scroll_documentation_down" "fallback"];
          "<CR>" = ["accept" "fallback"];
          "<C-x>" = ["show" "hide"];
        };

        signature.enabled = true;
        sources = {
          default = [
            "buffer"
            "lsp"
            "path"
            "snippets"
            "copilot"
            "emoji"
          ];

          providers = {
            emoji = {
              name = "Emoji";
              module = "blink-emoji";
              score_offset = 1;
            };
            copilot = {
              name = "copilot";
              module = "blink-copilot";
              async = true;
              score_offset = 100;
            };
          };
        };

        appearance = {
          nerd_font_variant = "mono";
          kind_icons = {
            Text = "󰉿";
            Method = "";
            Function = "󰊕";
            Constructor = "󰒓";

            Field = "󰜢";
            Variable = "󰆦";
            Property = "󰖷";

            Class = "󱡠";
            Interface = "󱡠";
            Struct = "󱡠";
            Module = "󰅩";

            Unit = "󰪚";
            Value = "󰦨";
            Enum = "󰦨";
            EnumMember = "󰦨";

            Keyword = "󰻾";
            Constant = "󰏿";

            Snippet = "󱄽";
            Color = "󰏘";
            File = "󰈔";
            Reference = "󰬲";
            Folder = "󰉋";
            Event = "󱐋";
            Operator = "󰪚";
            TypeParameter = "󰬛";
            Error = "󰏭";
            Warning = "󰏯";
            Information = "󰏮";
            Hint = "󰏭";

            Emoji = "🤶";
          };
        };

        completion = {
          menu = {
            border = "single";
            draw = {
              gap = 1;
              treesitter = ["lsp"];
              columns = [
                {
                  __unkeyed-1 = "label";
                }
                {
                  __unkeyed-1 = "kind_icon";
                  __unkeyed-2 = "kind";
                  gap = 1;
                }
                {__unkeyed-1 = "source_name";}
              ];
            };
          };
          trigger.show_in_snippet = false;
          documentation = {
            auto_show = true;
            window.border = "single";
          };
          accept.auto_brackets.enabled = false;
        };
      };
    };
  };
}
