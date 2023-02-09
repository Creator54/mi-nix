{ config, pkgs, lib, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; #doesnt work on false
    settings.General.Enable = "Source,Sink,Media,Socket";
  };
  services.blueman.enable = true;
}
