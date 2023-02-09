{ config, pkgs, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".config/nixpkgs/config.nix".source                   = link ./config.nix;
    ".config/gromit-mpx.ini".source                       = link ./gromit-mpx.ini;
    ".config/flameshot".source                            = link ./flameshot;
    ".config/fish".source                                 = link ./fish;
    ".config/xplr".source                                 = link ./xplr;
    ".config/mpv/scripts".source                          = link ./mpv/scripts;
    ".config/mpv/script-opts/youtube-quality.conf".source = link ./mpv/youtube-quality.conf;
    ".config/default.png".source                          = link ./default.png;
    ".config/gtk-3.0".source                              = link ./gtk-3.0;
    ".config/htop".source                                 = link ./htop;
    ".config/clipit".source                               = link ./clipit;
    ".icons".source                                       = link ./icons;
    ".xinitrc".source                                     = link ./xinitrc;
    ".Xresources".source                                  = link ./Xresources;
  };
}
