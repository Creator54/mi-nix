{ pkgs, ... }:
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
    ./doom-emacs.nix
    ./firefox/firefox.nix
  ];

#  services.kdeconnect = {
#    enable = true;
#    indicator = true;
#  };

  home.packages = with pkgs; [
    bc wget htop github-cli nnn openssl xplr
    aria2 nodejs libclang gcc gparted
    gnumake fzf vlc tdesktop ncftp comma
    capitaine-cursors fortune file gnome.nautilus
    colorpicker smartmontools jq kitty
    yt-dlp eva ueberzug tree qbittorrent
    unzip picom cmus conky fd #faster find alternative
    gromit-mpx pup progress starship nixos-option
    anydesk lm_sensors screenkey android-tools
    efibootmgr duf gdu xclip direnv clipit
    dig ffmpeg_5-full pciutils nix-index #contains nix-locate
    entr googler imgp recode glow yazi
    papirus-maia-icon-theme fff acpi sxiv axel python39 groff #for ms macros to pdf
    pandoc texlive.combined.scheme-small #for converting .md files to pdf
    ddgr ytfzf dua simplescreenrecorder
    (kodi.withPackages (p: with p; [ inputstream-adaptive pvr-iptvsimple inputstreamhelper ])) #kodi with jiotv, last is for drm
  ];
  nixpkgs.config.allowUnfree = true;
}
