{ config, pkgs, ... }:

let
  uc = (import ../userConfig.nix);
  hm = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${uc.stateVersion}.tar.gz";
in

{
  imports = [
    ./hardware.nix
    ./system/bt.nix
    ./kernels/latest.nix
    ./system/virtManager.nix
    ./system/docker.nix
    ./system/services.nix
    ./system/redshift.nix
    ./system/hosts.nix
    ../hm-stuff/home.nix
    (import "${hm}/nixos")
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        memtest86 = {
          enable = true;
        };
      };
      timeout = 0; #press Esc while booting if things get messy
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "${uc.host}";
    nameservers = ["1.1.1.1" "8.8.4.4" "8.8.8.8" "9.9.9.9"];
  };

  #https://discourse.nixos.org/t/fish-shell-and-manual-page-completion-nixos-home-manager/15661/3
  documentation.man.generateCaches = true;

  environment = {
    systemPackages = [ pkgs.home-manager ];
    pathsToLink = [ "/share/fish" ];
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  programs.fish.enable = true;
  users.users.${uc.user} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "power" "storage" "wheel" "audio" "video" "networkmanager" ];
    hashedPassword = uc.userHashedPass;
  };

  security.allowSimultaneousMultithreading = true;

  nix = {
    gc = {
      automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; #enable flakes
      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs.cachix.org"
        "https://nix-community.cachix.org"
        "file:///home/${uc.user}/.nix-cache"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true; #automatically detects files in the store that have identical contents and replaces with hard links.
      trusted-users = [ "root" "${uc.user}" ]; #for cachix to work
    };
  };

  nixpkgs.config.allowUnfree = true;
  time.hardwareClockInLocalTime = true;
  system.stateVersion = "${uc.stateVersion}";
}

