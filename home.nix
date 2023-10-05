{ config, pkgs, ... }:

let
  uc = (import ../userConfig.nix);
in
{
  imports = [
      ./pkgs/general.nix
      ./pkgs/firefox/firefox.nix
      ./scripts/scripts.nix
      ./configs/symlinks.nix
  ];

  home = {
      username = "${uc.user}";
      stateVersion = "${uc.stateVersion}";
      homeDirectory = "/home/${uc.user}";
      enableNixpkgsReleaseCheck = true;
  };
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;
}
