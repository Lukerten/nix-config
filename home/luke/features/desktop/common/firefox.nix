{ pkgs, inputs, ... }:
let
  defaultSettings = {
    "browser.download.panel.shown" = true;
    "browser.contentblocking.category" = "strict";
    "browser.newtabPage.activity-stream.improvedsearch.topSiteSearchShortcuts.haveP1inned" =
      "duckduckgo";
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.policies.applied" = true;
    "browser.loadInBackgr1ound" = true;
    "browser.tabs.loadInBackgr1ound" = true;
    "browser.tabs.warnOnClose" = false;
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";
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
      urls = [{
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
      }];
      icon = "https://nixos.wiki/favicon.ico";
      definedAliases = [ "@np" ];
    };

    "NixOS Wiki" = {
      urls =
        [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
      iconUpdateUrl = "https://nixos.wiki/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@nw" ];
    };

    "Wikipedia (de)" = {
      urls = [{
        template = "https://de.wikipedia.org/w/index.php";
        params = [{
          name = "search";
          value = "{searchTerms}";
        }];
      }];
      definedAliases = [ "@wd" ];
    };

    "Wikipedia (en)" = {
      urls = [{
        template = "https://en.wikipedia.org/w/index.php";
        params = [{
          name = "search";
          value = "{searchTerms}";
        }];
      }];
      definedAliases = [ "@we" ];
    };

    "Openstreetmap" = {
      urls = [{
        template = "https://www.openstreetmap.org/search?query={searchTerms}";
      }];
      definedAliases = [ "@osm" "@map" ];
    };

    "Youtube" = {
      urls = [{
        template = "https://www.youtube.com/results?search_query={searchTerms}";
      }];
      definedAliases = [ "@yt" ];
    };
    "Amazon".metaData.hidden = true;
    "Google".metaData.hidden = true;
    "Bing".metaData.hidden = true;
  };

  GitBookmarks = [
    {
      name = "Github";
      url = "https://github.com";
    }
    {
      name = "Gitlab FH-Erfurt";
      url = "https://git.ai.fh-erfurt.de";
    }
    {
      name = "Gitlab Private";
      url = "https://gitlab.mbretsch.de";
    }
  ];

  SocialBookmarks = [
    {
      name = "Reddit";
      url = "https://www.reddit.com";
    }
    {
      name = "Instagram";
      url = "https://www.instagram.com";
    }
    {
      name = "Twitter";
      url = "https://twitter.com";
    }
    {
      name = "Linkedin";
      url = "https://www.linkedin.com";
    }
  ];

  ResourcesBookmarks = [
    {
      name = "MDN";
      url = "https://developer.mozilla.org";
    }
    {
      name = "W3Schools";
      url = "https://www.w3schools.com";
    }
    {
      name = "Stackoverflow";
      url = "https://stackoverflow.com";
    }
    {
      name = "Nix Packages";
      url = "https://search.nixos.org/packages";
    }
    {
      name = "NixOS Wiki";
      url = "https://nixos.wiki";
    }
  ];

  WorkBookmarks = [
    {
      name = "United Internet";
      url = "https://united-internet.org";
    }
    {
      name = "Confluence";
      url = "https://confluence.cm4all.com";
    }
    {
      name = "Jira";
      url = "https://jira.cm4all.com";
    }
  ];

  FHErfurtBookmarks = [
    {
      name = "Moodle";
      url = "https://moodle.fh-erfurt.de";
    }
    {
      name = "Bibliothek";
      url = "https://katalog.fh-erfurt.de";
    }
    {
      name = "ECampus";
      url = "https://ecampus.fh-erfurt.de";
    }
    {
      name = "WebEx";
      url = "https://web.webex.com/spaces";
    }
    {
      name = "Mail";
      url = "https://fhemail.fh-erfurt.de";
    }
    {
      name = "Asana";
      url = "https://app.asana.com";
    }
  ];

  DevBookmarks = [
    {
      name = "Resources";
      bookmarks = ResourcesBookmarks;
    }
    {
      name = "Work";
      bookmarks = WorkBookmarks;
    }
    {
      name = "FH-Erfurt";
      bookmarks = FHErfurtBookmarks;
    }
  ];

  FFXIVBookmarks = [
    {
      name = "Lodestone";
      url = "https://eu.finalfantasyxiv.com/lodestone";
    }
    {
      name = "FFLogs";
      url = "https://www.fflogs.com";
    }
    {
      name = "XIVAPI";
      url = "https://xivapi.com";
    }
    {
      name = "Garland Tools";
      url = "https://www.garlandtools.org";
    }
  ];

  BG3Bookmarks = [
    {
      name = "Builds";
      bookmarks = [
        {
          name = "Eldrich Knight";
          url = "https://alcasthq.com/bg3-eldritch-knight-fighter-build-guide/";
        }
        {
          name = "Beast Master";
          url = "https://alcasthq.com/bg3-beast-master-ranger-build-guide/";
        }
        {
          name = "Wild Heart";
          url = "https://alcasthq.com/bg3-wildheart-barbarian-build-guide/";
        }
        {
          name = "Life Domain Cleric";
          url =
            "https://www.thegamer.com/baldurs-gate-3-bg3-best-life-domain-cleric-build-guide/";
        }
        {
          name = "PalaBard";
          url = "https://alcasthq.com/bg3-bard-paladin-multiclass-build/";
        }
      ];
    }
    {
      name = "Wiki";
      bookmarks = [
        {
          name = "Approval";
          url = "https://bg3.wiki/wiki/Shadowheart/approval";
        }
        {
          name = "Weapons";
          url = "https://bg3.wiki/wiki/Weapons";
        }
      ];
    }
  ];

  WarframeBookmarks = [
    {
      name = "Wiki";
      url = "https://warframe.fandom.com/wiki/WARFRAME_Wiki";
    }
    {
      name = "Rivenmarket";
      url = "https://riven.market";
    }
    {
      name = "Market";
      url = "https://warframe.market";
    }
    {
      name = "Overframe";
      url = "https://overframe.gg";
    }
  ];

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
    DisplayMenuBar =
      "default-off"; # alternatives: "always", "never" or "default-on"
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
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/ftp" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];

    # use firefox to view images
    "image/jpeg" = [ "firefox.desktop" ];
    "image/png" = [ "firefox.desktop" ];
    "image/gif" = [ "firefox.desktop" ];
    "image/bmp" = [ "firefox.desktop" ];
    "image/webp" = [ "firefox.desktop" ];
    "image/svg+xml" = [ "firefox.desktop" ];
    "image/x-windows-bmp" = [ "firefox.desktop" ];
    "image/x-portable-bitmap" = [ "firefox.desktop" ];
    "image/x-portable-graymap" = [ "firefox.desktop" ];
    "image/x-portable-pixmap" = [ "firefox.desktop" ];
    "image/x-xbitmap" = [ "firefox.desktop" ];
    "image/x-xpixmap" = [ "firefox.desktop" ];
    "image/x-xwindowdump" = [ "firefox.desktop" ];
    "image/tiff" = [ "firefox.desktop" ];
    "image/x-icon" = [ "firefox.desktop" ];
    "image/vnd.microsoft.icon" = [ "firefox.desktop" ];
    "image/vnd.wap.wbmp" = [ "firefox.desktop" ];
    "image/x-jng" = [ "firefox.desktop" ];
  };
}
