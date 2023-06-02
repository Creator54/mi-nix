{ config, pkgs, lib, ... }:

let
  startPage = builtins.fetchurl{
   url = "https://raw.githubusercontent.com/Creator54/tilde/main/index.html";
   sha256 = "sha256:0yy41c1hxkypfdjddv9bqghciyc3g1jr9q1jbrpi5s67vw4mwhhc";
  };
  userChromeCSS = builtins.fetchurl{
    url = "https://raw.githubusercontent.com/creator54/cascade/main/userChrome.css";
    sha256 = "sha256:18rplkfnx4mszh9gl4nyz9mkar57s13cgyzgiyyah9z6mpdjbmc1";
  };
in
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball{
      url = "https://github.com/nix-community/NUR/archive/d20910e4325043886e32c8d459b727e1e5be079e.tar.gz";
      sha256 = "sha256:0rzcslnig64flpb4hyxlpbdjnyl0k3aygb3y78yk0klraqrm2vis";
      }) {
      inherit pkgs;
    };
  };

  programs = {
    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        stylus
        noscript
        wappalyzer
        darkreader
        sponsorblock
        ublock-origin
        #https-everywhere
        facebook-container
        return-youtube-dislikes
        multi-account-containers
        user-agent-string-switcher
        terms-of-service-didnt-read
        duckduckgo-privacy-essentials
      ];
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        #userChrome = builtins.readFile "/home/creator54/cascade/userChrome.css";
        userChrome = builtins.readFile userChromeCSS;
        settings = { #about:config
        "browser.startup.homepage" = "${startPage}";
        "browser.search.region" = "IN";
        "browser.search.isUS" = false;
        "browser.download.animateNotifications" = false;
        "security.dialog_enable_delay" = 0;
        "distribution.searchplugins.defaultLocale" = "en-IN";
        "general.useragent.locale" = "en-IN";
        "browser.bookmarks.showMobileBookmarks" = true;
        "ui.systemUsesDarkTheme" = 1;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "extensions.webextensions.restrictedDomains" = ""; #enable adding custom css even on restricted/firefox sites.
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        };
      };
    };
  };
}
