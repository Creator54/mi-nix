{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./CosPi/configuration.nix
  ];

  networking = {
    networkmanager.enable = true;
    wireless.enable = false;
  };

  boot.loader.timeout = 10;
}
