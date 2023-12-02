{ config, pkgs, lib, ... }:
let
  uc = (import ../../userConfig.nix);
in
{
  programs = {
    git = {
      enable = true;
      userName = "${uc.user}";
      userEmail = "${uc.userEmail}";
    };
    lazygit.enable = true;
  };
}
