{ config, pkgs, ... }:

let
  uc = (import ../userConfig.nix);
in
{
  home-manager.users.${uc.user} = { pkgs, ... }: {
    imports = [
      ./wm/dwm.nix
      ./wm/wm-pkgs.nix
      ./pkgs/general.nix
      ./scripts/scripts.nix
      ./configs/symlinks.nix
      ./configs/gtk.nix
    ];

    home = {
      username = "${uc.user}";
      stateVersion = "${uc.stateVersion}";
      homeDirectory = "/home/${uc.user}";
      enableNixpkgsReleaseCheck = true;
    };
  };
}
