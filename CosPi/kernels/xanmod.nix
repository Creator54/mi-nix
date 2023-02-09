{ config, pkgs, modulesPath, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };
}
