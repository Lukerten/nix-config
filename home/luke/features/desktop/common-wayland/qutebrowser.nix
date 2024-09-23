{
  config,
  pkgs,
  lib,
  ...
}: let
  defaultPage = "https://start.duckduckgo.com/";

  inherit (config.colorscheme) colors;
  searchEngines = rec {
    duckduckgo = "https://duckduckgo.com/?q={}";
    google = "https://google.com/search?hl=en&q={}";
    nixospackages = "https://search.nixos.org/packages?query={}";
    nixoswiki = "https://nixos.wiki/index.php?search={}";
    wikipedia = "https://de.wikipedia.org/w/index.php?search={}";
    openstreetmap = "https://www.openstreetmap.org/search?query={}";
    youtube = "https://www.youtube.com/results?search_query={}";

    # Shortcuts
    ddg = duckduckgo;
    g = google;
    nixpkgs = nixospackages;
    np = nixospackages;
    nixwiki = nixoswiki;
    nw = nixoswiki;
    wiki = wikipedia;
    osm = openstreetmap;
    map = openstreetmap;
    yt = youtube;
    DEFAULT = ddg;
  };

  quickmarks = {
    "home" = defaultPage;
    "nixos" = "https://nixos.org/";
    "nixpkgs" = "https://nixos.org/nixpkgs/";
    "gmail" = "https://mail.google.com/";
    "outlook" = "https://outlook.office365.com/mail/inbox";
    "calendar" = "https://calendar.google.com/";
    "github" = "https://github.com/";
    "gitlab" = "https://gitlab.mbretsch.de/";
    "yt" = "https://www.youtube.com/";
    "openai" = "https://chat.openai.com";

    # FHE Student
    "fh/gitlab" = "https://git.ai.fh-erfurt.de/";
    "fh/ecampus" = "https://ecampus.fh-erfurt.de/";
    "fh/moodle" = "https://moodle.fh-erfurt.de/";
    "fh/webmail" = "https://fhemail.fh-erfurt.de/";
    "fh/nextcloud" = "https://cloud.fh-erfurt.de/";

    # FHE FSR
    "fsr/fsrmail" = "https://group.fh-erfurt.de/";
    "fsr/asana" = "https://app.asana.com/";
    "fsr/dbl-tool" = "https://fh-erfurt.biccloud.de";

    # CM4all
    "cm/gitlab" = "https://dev.t8o.de";
    "cm/openstack" = "https://os.t8o.de";
    "cm/confluence" = "https://cm4all.atlassian.net/";

    # United Internet
    "ui/gitlab" = "https://gitlab.smb.server.lan/";
    "ui/confluence" = "https://confluence.united-internet.org/";
    "ui/united" = "https://united-internet.org/";
  };

  custom-binds = {
    normal = {
      "e" = "spawn --userscript qute-pass";
      "E" = "spawn --userscript qute-pass --password-only";
      "<ctrl-v>" = "spawn mpv {url}";
      "<f1>" = lib.mkMerge [
        "config-cycle tabs.show never always"
        "config-cycle statusbar.show in-mode always"
        "config-cycle scrolling.bar never always"
      ];
      "n" = "open -t ${defaultPage}";
    };
    prompt = {
      "<ctrl-y>" = "prompt-yes";
      "<ctrl-v>" = "insert-text {primary}";
      "n" = "open -t ${defaultPage}";
    };
  };

  customStlyeSheet =
    #scss
    ''
      ::-webkit-scrollbar-track {
        border-radius: 4px;
      }
      ::-webkit-scrollbar-thumb {
        background-color: ${colors.on_surface};
        border-radius: 4px;
      }
      ::-webkit-scrollbar-thumb:vertical {
        box-shadow: inset 0 0 6px ${colors.surface};
      }
      ::-webkit-scrollbar-thumb:horizontal {
        box-shadow: inset 0 0 6px ${colors.surface};
      }
      ::-webkit-scrollbar-corner {
        background-color: ${colors.surface};
      }
    '';
in {
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
    "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
  };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    searchEngines = searchEngines;
    quickmarks = quickmarks;
    keyBindings = custom-binds;
    settings = {
      url = rec {
        default_page = "https://start.duckduckgo.com/";
        start_pages = [default_page];
      };
      downloads.open_dispatcher = "${lib.getExe pkgs.handlr-regex} open {}";
      editor.command = ["${lib.getExe pkgs.handlr-regex}" "open" "{file}"];
      tabs = {
        show = "multiple";
        position = "top";
        indicator.width = 0;
      };
      fonts = {
        default_family = config.fontProfiles.regular.name;
        default_size = "${toString config.fontProfiles.regular.size}pt";
      };
      colors = {
        webpage.preferred_color_scheme = "auto";
        completion = {
          fg = colors.on_surface;
          match.fg = colors.primary;
          even.bg = colors.surface_dim;
          odd.bg = colors.surface_bright;
          scrollbar = {
            bg = colors.surface;
            fg = colors.on_surface;
          };
          category = {
            bg = colors.secondary;
            fg = colors.on_secondary;
            border = {
              bottom = colors.surface;
              top = colors.surface;
            };
          };
          item.selected = {
            bg = colors.primary;
            fg = colors.on_primary;
            match.fg = colors.tertiary;
            border = {
              bottom = colors.outline;
              top = colors.outline;
            };
          };
        };
        contextmenu = {
          disabled = {
            bg = colors.surface_dim;
            fg = colors.on_surface_variant;
          };
          menu = {
            bg = colors.surface;
            fg = colors.on_surface;
          };
          selected = {
            bg = colors.secondary;
            fg = colors.on_secondary;
          };
        };
        downloads = {
          bar.bg = colors.surface_dim;
          error = {
            fg = colors.on_error;
            bg = colors.error;
          };
          start = {
            bg = colors.primary;
            fg = colors.on_primary;
          };
          stop = {
            bg = colors.secondary;
            fg = colors.on_secondary;
          };
        };
        hints = {
          bg = colors.secondary;
          fg = colors.on_secondary;
          match.fg = colors.on_surface;
        };
        keyhint = {
          bg = colors.surface;
          fg = colors.on_surface;
          suffix.fg = colors.on_surface;
        };
        messages = {
          error = {
            bg = colors.error;
            border = colors.outline;
            fg = colors.on_error;
          };
          info = {
            bg = colors.secondary;
            border = colors.outline;
            fg = colors.on_secondary;
          };
          warning = {
            bg = colors.primary;
            border = colors.outline;
            fg = colors.on_primary;
          };
        };
        prompts = {
          bg = colors.surface;
          fg = colors.on_surface;
          border = colors.surface;
          selected.bg = colors.inverse_primary;
        };
        statusbar = {
          caret = {
            bg = colors.surface;
            fg = colors.on_surface;
            selection = {
              bg = colors.surface;
              fg = colors.on_surface_variant;
            };
          };
          command = {
            bg = colors.surface_bright;
            fg = colors.on_surface;
            private = {
              bg = colors.surface_bright;
              fg = colors.on_surface;
            };
          };
          insert = {
            bg = colors.surface;
            fg = colors.primary;
          };
          normal = {
            bg = colors.surface;
            fg = colors.on_surface;
          };
          passthrough = {
            bg = colors.secondary;
            fg = colors.on_secondary;
          };
          private = {
            bg = colors.tertiary;
            fg = colors.on_tertiary;
          };
          progress.bg = colors.tertiary;
          url = {
            error.fg = colors.error;
            fg = colors.on_surface;
            success = {
              http.fg = colors.secondary;
              https.fg = colors.secondary;
            };
            warn.fg = colors.tertiary;
          };
        };
        tabs = {
          bar.bg = colors.surface;
          even = {
            bg = colors.surface_bright;
            fg = colors.on_surface;
          };
          odd = {
            bg = colors.surface_dim;
            fg = colors.on_surface;
          };
          selected = {
            even = {
              bg = colors.primary;
              fg = colors.on_primary;
            };
            odd = {
              bg = colors.primary;
              fg = colors.on_primary;
            };
          };
          pinned = {
            even = {
              bg = colors.surface_bright;
              fg = colors.tertiary;
            };
            odd = {
              bg = colors.surface_dim;
              fg = colors.tertiary;
            };
            selected = {
              even = {
                bg = colors.tertiary;
                fg = colors.on_tertiary;
              };
              odd = {
                bg = colors.tertiary;
                fg = colors.on_tertiary;
              };
            };
          };
        };
      };
    };
    extraConfig = ''
      c.tabs.padding = {"bottom": 10, "left": 10, "right": 10, "top": 10}
      c.content.user_stylesheets = "scrollbar.css"
      c.scrolling.bar = "overlay"
      c.scrolling.smooth = True
    '';
  };

  xdg.configFile."qutebrowser/scrollbar.css".text = customStlyeSheet;
  xdg.configFile."qutebrowser/config.py".onChange = lib.mkForce ''
    ${pkgs.procps}/bin/pkill -u $USER -HUP qutebrowser || true
  '';

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
    "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "application/xhtml+xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
  };
}
