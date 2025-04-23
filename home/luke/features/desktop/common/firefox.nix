{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  hasQutebrowser = config.programs.qutebrowser.enable;
in {
  programs.browserpass.enable = !hasQutebrowser;
  programs.firefox = {
    package = pkgs.firefox;
    enable = !hasQutebrowser;
    profiles = {
      luke = {
        id = 0;
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          order = [
            "ddg"
            "Nix Packages"
            "NixOS Wiki"
            "wikipedia-de"
            "wikipedia"
          ];
          engines = {
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

            "wikipedia-de" = {
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

            "wikipedia" = {
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

            "openstreetmap" = {
              urls = [
                {
                  template = "https://www.openstreetmap.org/search?query={searchTerms}";
                }
              ];
              definedAliases = ["@osm" "@map"];
            };

            "youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results?search_query={searchTerms}";
                }
              ];
              definedAliases = ["@yt"];
            };
            "amazon".metaData.hidden = true;
            google.metaData.hidden = true;
            bing.metaData.hidden = true;
          };
        };
        extensions.packages = with pkgs.inputs.firefox-addons; [
          ublock-origin
          browserpass
        ];
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
            "26UbzFJ7qT9/4DhodHKA1Q=="
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
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
        };
      };
    };
  };
  xdg.mimeApps.defaultApplications = mkIf (!hasQutebrowser) {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
