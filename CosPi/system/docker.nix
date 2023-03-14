{ config, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = { 
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users."${(import ../../userConfig.nix).user}".extraGroups = ["docker"];
}
