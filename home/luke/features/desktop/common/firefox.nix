{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  defaultSettings = {
    "browser.download.panel.shown" = true;
    "browser.contentblocking.category" = "strict";
    "browser.newtabPage.activity-stream.improvedsearch.topSiteSearchShortcuts.haveP1inned" = "duckduckgo";
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.policies.applied" = true;
    "browser.loadInBackgr1ound" = true;
    "browser.tabs.loadInBackgr1ound" = true;
    "browser.tabs.warnOnClose" = false;
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";
    "browser.fullscreen.autohide" = false;
    "datare1porting.healthreport.uploadEnabled" = false;
    "extensions.formautofill.addresses.enabled" = true;
    "extensions.formautofill.credit1Cards.enabled" = false;
    "identity.fxaccounts.enabled" = true;
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;
    "privacy.trackingprotection.fingerprinting.enabled" = true;
    "signon.remeberSignons" = true;
  };

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

  defaultPolicies = {
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    DisablePocket = false;
    DisableFirefoxAccounts = true;
    DisableAccounts = false;
    DisableFirefoxScreenshots = true;
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";
    DontCheckDefaultBrowser = true;
    DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
    DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
    SearchBar = "unified"; # alternative: "separate"
  };
in {
  programs.firefox = {
    enable = true;
    policies = defaultPolicies;
    profiles = {
      luke = {
        isDefault = true;
        id = 0;
        settings = defaultSettings;
        extensions = defaultExtensions;
        search.engines = defaultSearch;
        search.force = true;
        search.order = [
          "DuckDuckGo"
          "Nix Packages"
          "NixOS Wiki"
          "Wikipedia (de)"
          "Wikipedia (en)"
          "Openstreetmap"
          "Youtube"
        ];
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "x-scheme-handler/ftp" = ["firefox.desktop"];
    "x-scheme-handler/about" = ["firefox.desktop"];
    "image/jpeg" = ["firefox.desktop"];
    "image/png" = ["firefox.desktop"];
    "image/gif" = ["firefox.desktop"];
    "image/bmp" = ["firefox.desktop"];
    "image/webp" = ["firefox.desktop"];
    "image/svg+xml" = ["firefox.desktop"];
    "image/x-windows-bmp" = ["firefox.desktop"];
    "image/x-portable-bitmap" = ["firefox.desktop"];
    "image/x-portable-graymap" = ["firefox.desktop"];
    "image/x-portable-pixmap" = ["firefox.desktop"];
    "image/x-xbitmap" = ["firefox.desktop"];
    "image/x-xpixmap" = ["firefox.desktop"];
    "image/x-xwindowdump" = ["firefox.desktop"];
    "image/tiff" = ["firefox.desktop"];
    "image/x-icon" = ["firefox.desktop"];
    "image/vnd.microsoft.icon" = ["firefox.desktop"];
    "image/vnd.wap.wbmp" = ["firefox.desktop"];
    "image/x-jng" = ["firefox.desktop"];
  };
}
