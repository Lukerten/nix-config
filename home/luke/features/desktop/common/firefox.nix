
{
  pkgs,
  lib,
  config,
  ...
}: let
  defaultExtensions = with pkgs.inputs.firefox-addons; [
    ublock-origin
    adblocker-ultimate
    joplin-web-clipper
    keepassxc-browser
    react-devtools
    reduxdevtools
  ];

  defaultSearch = {
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages?";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = "unstable";
            }
          ];
        }
      ];
      icon = "https://nixos.wiki/favicon.ico";
      definedAliases = ["@np"];
    };

    "NixOS Wiki" = {
      urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
      iconUpdateUrl = "https://nixos.wiki/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = ["@nw"];
    };

    "Wikipedia (de)" = {
      urls = [
        {
          template = "https://de.wikipedia.org/w/index.php";
          params = [
            {
              name = "search";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      definedAliases = ["@wd"];
    };

    "Wikipedia (en)" = {
      urls = [
        {
          template = "https://en.wikipedia.org/w/index.php";
          params = [
            {
              name = "search";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      definedAliases = ["@we"];
    };

    "Openstreetmap" = {
      urls = [
        {
          template = "https://www.openstreetmap.org/search?query={searchTerms}";
        }
      ];
      definedAliases = ["@osm" "@map"];
    };

    "Youtube" = {
      urls = [
        {
          template = "https://www.youtube.com/results?search_query={searchTerms}";
        }
      ];
      definedAliases = ["@yt"];
    };
    "Amazon".metaData.hidden = true;
    "Google".metaData.hidden = true;
    "Bing".metaData.hidden = true;
  };

  settings = {
        "browser.startup.homepage" = "about:home";
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          "eV8/WsSLxHadrTL1gAxhug=="
          "gLv0ja2RYVgxKdp0I5qwvA=="
          "K00ILysCaEq8+bEqV/3nuw=="
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "reset-pbm-toolbar-button" "unified-extensions-button"];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = [];
            widget-overflow-fixed-list = [];
          };
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
        };
      };
in {
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.luke = {
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = defaultSearch;
        order = [
          "DuckDuckGo"
          "Nix Packages"
          "NixOS Wiki"
          "Wikipedia (de)"
          "Wikipedia (en)"
          "Openstreetmap"
          "Youtube"
        ];
      };
      bookmarks = {};
      extensions = with pkgs.inputs.firefox-addons; [
        ublock-origin
        browserpass
      ];
      bookmarks = {};
      settings = settings;
    };
  };

  xdg.mimeApps.defaultApplications = lib.mkIf (!config.programs.qutebrowser.enable) {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}

