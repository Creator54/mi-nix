{ config, pkgs, ... }:

let
  userConfig = (import ../userConfig.nix);
  cfg = ./configs;
in
{
  home-manager.users.${userConfig.user} = { pkgs, ... }: {
    imports = [
      ./wm/dwm.nix
      ./wm/wm-pkgs.nix
      ./pkgs/general.nix
      ./pkgs/firefox.nix
    ];

    home = {
      username = "${userConfig.user}";
      stateVersion = "${userConfig.stateVersion}";
      homeDirectory = "/home/${userConfig.user}";
      enableNixpkgsReleaseCheck = true;

      file = {
        ".config/nixpkgs/config.nix".source                   = "${cfg}/config.nix";
        ".config/gromit-mpx.ini".source                       = "${cfg}/gromit-mpx.ini";
        ".config/flameshot".source                            = "${cfg}/flameshot";
        ".config/fish".source                                 = "${cfg}/fish";
        ".config/xplr".source                                 = "${cfg}/xplr";
        ".config/mpv/scripts".source                          = "${cfg}/mpv/scripts";
        ".config/mpv/script-opts/youtube-quality.conf".source = "${cfg}/mpv/youtube-quality.conf";
        ".config/default.png".source                          = "${cfg}/default.png";
        ".config/gtk-3.0".source                              = "${cfg}/gtk-3.0";
        ".config/htop".source                                 = "${cfg}/htop";
        ".config/clipit".source                               = "${cfg}/clipit";
        ".icons".source                                       = "${cfg}/icons";
        ".xinitrc".source                                     = "${cfg}/xinitrc";
        ".Xresources".source                                  = "${cfg}/Xresources";
      };
    };
  };
}
