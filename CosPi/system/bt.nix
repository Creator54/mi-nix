{ config, pkgs, lib, ... }:

let
  bluez = pkgs.bluezFull.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++ [ "--enable-experimental" ];
  });
in

{

  hardware = { #If no audio,check output devices in pavucontrol
    bluetooth = {
      enable = true;
      package = bluez;
      powerOnBoot = true;
    };
  };

  services = {
    blueman.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ bluez ];
    };
  };

  systemd.services = {
    bluetoothUnblock = {
      description = "Unblock Bluetooth on startup";
      serviceConfig = {
        ExecStart = "/run/current-system/sw/bin/rfkill unblock all";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
