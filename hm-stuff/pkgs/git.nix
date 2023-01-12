{ config, pkgs, lib, ... }:
let
  userConfig = (import ../../userConfig.nix);
in
{
  programs.git = {
    enable = true;
    userName = "${userConfig.user}";
    userEmail = "${userConfig.userEmail}";
  };
}
