{ config, pkgs, ... }:

let
  userConfig = (import ../userConfig.nix);
  cfg = "/home/${userConfig.user}/.config/nixpkgs/configs";
in
{
  home-manager.users.${userConfig.user} = { pkgs, ... }: {
    imports = [
      ./wm/dwm.nix
      ./wm/wm-pkgs.nix
      ./pkgs/general.nix
      ./pkgs/firefox.nix
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text" = [ "neovide" "vim" ];
        "file" = [ "neovide" "vim" ];
        "log" = [ "neovide" "vim" ];
        "jpg" = [ "sxiv" ];
      };
    };

    home = {
      username = "${userConfig.user}";
      stateVersion = "${userConfig.stateVersion}";
      homeDirectory = "/home/${userConfig.user}";
      enableNixpkgsReleaseCheck = true;

      file = {
        ".config/gromit-mpx.ini".source                       = "${cfg}/gromit-mpx.ini";
        ".config/flameshot".source                            = "${cfg}/flameshot";
        ".config/fish".source                                 = "${cfg}/fish";
        ".config/xplr".source                                 = "${cfg}/xplr";
        ".config/mpv/scripts".source                          = "${cfg}/mpv/scripts";
        ".config/mpv/script-opts/youtube-quality.conf".source = "${cfg}/mpv/youtube-quality.conf";
        ".config/gtk-3.0".source                              = "${cfg}/gtk-3.0";
        ".config/htop".source                                 = "${cfg}/htop";
        ".icons".source                                       = "${cfg}/icons";
        ".xinitrc".source                                     = "${cfg}/xinitrc";
        ".Xresources".source                                  = "${cfg}/Xresources";
      };
    };
  };
}
