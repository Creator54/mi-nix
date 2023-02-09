{ config, pkgs, ... }:

let
  userConfig = (import ../userConfig.nix);
in
{
  home-manager.users.${userConfig.user} = { pkgs, ... }: {
    imports = [
      ./wm/dwm.nix
      ./wm/wm-pkgs.nix
      ./pkgs/general.nix
      ./pkgs/firefox.nix
      ./configs/symlinks.nix
    ];

    home = {
      username = "${userConfig.user}";
      stateVersion = "${userConfig.stateVersion}";
      homeDirectory = "/home/${userConfig.user}";
      enableNixpkgsReleaseCheck = true;
    };
  };
}
