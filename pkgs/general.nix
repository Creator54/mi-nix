{ config, pkgs, lib, ... }:
let
  unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
  { config = config.nixpkgs.config; };
in
#using unstable means regular updates, ie more data usage
{
  imports = [
    ./git.nix
    ./bat.nix
    ./mpv.nix
    ./nvim.nix
    ./fonts.nix
    ./mcfly.nix
    ./zathura.nix
    ./ani-cli.nix
  ];

  home.packages = with pkgs;[
    bc htop github-cli nnn openssl xplr
    aria2 nodejs libclang gcc
    gnumake fzf tdesktop ncftp
    capitaine-cursors fortune
    colorpicker smartmontools jq kitty
    yt-dlp eva tree qbittorrent
    unzip picom cmus conky fd #faster find alternative
    gromit-mpx pup progress starship nixos-option
    anydesk lm_sensors screenkey android-tools
    efibootmgr duf gdu xclip direnv clipit
    dig ffmpeg_5-full pciutils nix-index #contains nix-locate
    entr imgp recode glow
    papirus-maia-icon-theme fff acpi sxiv axel python39 groff #for ms macros to pdf
    pandoc texlive.combined.scheme-small #for converting .md files to pdf
    ytfzf google-chrome openjdk gradle maven 
    #(kodi.withPackages (p: with p; [ inputstream-adaptive pvr-iptvsimple inputstreamhelper ])) #kodi with jiotv, last is for drm
  ];
  nixpkgs.config.allowUnfree = true;
}
